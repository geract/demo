class RescuerProfile < ApplicationRecord
  belongs_to :rescuer, class_name: 'Rescuer', foreign_key: 'user_id', optional: true
  belongs_to :organization, optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true
end
