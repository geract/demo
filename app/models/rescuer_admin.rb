class RescuerAdmin < User
  include PasswordSetup

  has_one :profile, class_name: 'RescuerAdminProfile', foreign_key: 'user_id'
  has_one :organization, through: :profile

  accepts_nested_attributes_for :profile, update_only: true
end
