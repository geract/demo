module PasswordSetup
  extend ActiveSupport::Concern

  included do
    before_save -> { skip_confirmation! }
    before_validation :set_password, on: :create
  end

  def password_token
    set_reset_password_token
  end

  private

  def set_password
    self.password = Rails.application.credentials.rescuer_admin_default_password
  end
end
