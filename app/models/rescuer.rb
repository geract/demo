class Rescuer < User
  include PasswordSetup
  include Rescuers::StateManager

  devise :database_authenticatable, :recoverable,
    :rememberable, :validatable

  has_one :profile, class_name: 'RescuerProfile', foreign_key: 'user_id'
  has_one :organization, through: :profile

  scope :by_name, ->{ order(:first_name) }
  scope :by_name_and_status, ->(status) { where(status: status).by_name }

  accepts_nested_attributes_for :profile, update_only: true
end
