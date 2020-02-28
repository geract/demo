class Rescuer < User
  include PasswordSetup
  include Rescuers::StateManager

  devise :database_authenticatable, :recoverable,
    :rememberable, :validatable

  scope :by_name, ->{ order(:first_name) }
  scope :by_name_and_status, ->(status) { where(status: status).by_name }
end
