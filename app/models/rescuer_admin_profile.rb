class RescuerAdminProfile < RescuerProfile
  belongs_to :rescuer, class_name: 'RescuerAdmin', foreign_key: 'user_id', optional: true

  validates :phone, presence: true
end