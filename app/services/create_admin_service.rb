class CreateAdminService
  def call
    secrets = Rails.application.secrets

    user = User.find_or_create_by!(email: secrets.admin_email) do |user|
      user.password = secrets.admin_password
      user.password_confirmation = secrets.admin_password
      user.confirm!
    end
  end
end
