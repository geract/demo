class Rescuer < User
  include PasswordSetup
  include Rescuers::StateManager

  devise :database_authenticatable, :recoverable,
    :rememberable, :validatable

  has_one :profile, class_name: 'RescuerProfile', foreign_key: 'user_id'
  has_one :organization, through: :profile
  has_many :messages, as: :senderable, dependent: :destroy

  scope :order_by_name, ->{ order(:first_name) }
  scope :by_status, ->(status) { where(status: status) }

  validates :password, presence: true, if: ->{ password.present? }, on: :update

  accepts_nested_attributes_for :profile, update_only: true
end
