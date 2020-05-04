class RescuerAdminProfile < RescuerProfile
  belongs_to :admin, class_name: 'RescuerAdmin', foreign_key: 'user_id', optional: true
  
  has_one_attached :photo

  validates :phone, presence: true

  accepts_nested_attributes_for :admin, update_only: true
end