# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'bindus'
set :repo_url, 'git@github.com:utnas/bindus.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do


  after :publishing, :restart
  desc 'Restart application'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :deploy => ['deploy:push', 'deploy:restart', 'deploy:tag']

  task :migrations => [:push, :off, :migrate, :restart, :on, :tag]
  task :rollback => [:off, :push_previous, :restart, :on]

  task :push do
    puts 'Deploying site to Heroku ...'
    puts 'git push heroku'
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      puts 'Restarting app servers ...'
      puts 'heroku restart'
    end
  end

  task :tag do
    release_name = "release-#{Time.now.utc.strftime('%Y%m%d%H%M%S')}"
    puts "Tagging release as '#{release_name}'"
    puts "git tag -a #{release_name} -m 'Tagged release'"
    puts 'git push --tags heroku'
  end

  task :migrate do
    puts 'Running database migrations ...'
    puts 'heroku rake db:migrate'
  end

  task :off do
    puts 'Putting the app into maintenance mode ...'
    puts 'heroku maintenance:on'
  end

  task :on do
    puts 'Taking the app out of maintenance mode ...'
    puts 'heroku maintenance:off'
  end

  task :push_previous do
    releases = 'git tag'.split("\n").select { |t| t[0..7] == 'release-' }.sort
    current_release = releases.last
    previous_release = releases[-2] if releases.length >= 2
    if previous_release
      puts "Rolling back to '#{previous_release}' ..."

      puts "Checking out '#{previous_release}' in a new branch on local git repo ..."
      puts "git checkout #{previous_release}"
      puts "git checkout -b #{previous_release}"

      puts "Removing tagged version '#{previous_release}' (now transformed in branch) ..."
      puts "git tag -d #{previous_release}"
      puts "git push heroku :refs/tags/#{previous_release}"

      puts "Pushing '#{previous_release}' to Heroku master ..."
      puts "git push heroku +#{previous_release}:master --force"

      puts "Deleting rollback release '#{current_release}' ..."
      puts "git tag -d #{current_release}"
      puts "git push heroku :refs/tags/#{current_release}"

      puts "Retagging release '#{previous_release}' in case to repeat this process (other rollbacks)..."
      puts "git tag -a #{previous_release} -m 'Tagged release'"
      puts 'git push --tags heroku'

      puts 'Turning local repo checked out on master ...'
      puts 'git checkout master'
      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
      puts releases
    end
  end
end
