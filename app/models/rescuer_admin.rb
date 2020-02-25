class RescuerAdmin < User
  include PasswordSetup

  devise :database_authenticatable, :recoverable,
    :rememberable, :validatable
end
