class RescuerAdmin < User
  devise :database_authenticatable, :recoverable,
    :rememberable, :validatable

  before_save -> { skip_confirmation! }
  before_validation :set_password, on: :create

  def password_token
    set_reset_password_token
  end

  private

  def set_password
    self.password = Rails.application.credentials.rescuer_admin_default_password
  end
end
