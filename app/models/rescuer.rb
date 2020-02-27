class Rescuer < User
  include PasswordSetup
  include Rescuers::StateManager

  devise :database_authenticatable, :recoverable,
    :rememberable, :validatable
end
