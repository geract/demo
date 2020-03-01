class Rescuer < User
  include PasswordSetup
  include Rescuers::StateManager

  devise :database_authenticatable, :recoverable,
    :rememberable, :validatable

  has_one :profile, class_name: 'RescuerProfile', foreign_key: 'user_id'
  has_one :organization, through: :profile

  scope :order_by_name, ->{ order(:first_name) }
  scope :by_status, ->(status) { where(status: status) }

  accepts_nested_attributes_for :profile, update_only: true
end
