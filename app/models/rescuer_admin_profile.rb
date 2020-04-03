class RescuerAdminProfile < RescuerProfile
  belongs_to :rescuer, class_name: 'RescuerAdmin', foreign_key: 'user_id', optional: true
  
  has_one_attached :photo

  validates :phone, presence: true
end
