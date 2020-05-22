class FavoritePet < ApplicationRecord
  belongs_to :adopter, class_name: 'Adopter', foreign_key: 'user_id'
  belongs_to :pet

  validates :user_id, uniqueness: { scope: :pet_id }
end
