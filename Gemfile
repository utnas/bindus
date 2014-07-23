source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.1.4'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bootstrap-sass'
gem 'devise'
gem 'simple_form'

gem 'node-rails', git: 'https://github.com/cloudspace/node-rails.git'
gem 'socket.io-rails', git: 'https://github.com/jhchen/socket.io-rails.git'
gem 'websocket-rails', git: 'git://github.com/DanKnox/websocket-rails.git'
gem 'juggernaut'

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'thin'
  gem 'sqlite3'
end
group :production do
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'pg'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end
