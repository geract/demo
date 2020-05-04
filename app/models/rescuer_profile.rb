class RescuerProfile < ApplicationRecord
  belongs_to :rescuer, class_name: 'Rescuer', foreign_key: 'user_id', optional: true
  belongs_to :organization, optional: true

  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :title, presence: true, on: :update
end
