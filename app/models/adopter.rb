class Adopter < User
  has_one :profile, class_name: 'AdopterProfile', foreign_key: 'user_id'

  has_many :searches, class_name: 'Search', foreign_key: 'user_id'
  has_many :pet_applications, through: :profile
  has_many :messages, as: :senderable, dependent: :destroy
  has_many :favorites, class_name: 'FavoritePet', foreign_key: 'user_id'
  has_many :favorite_pets, through: :favorites, source: :pet

  accepts_nested_attributes_for :profile

  validates :password, presence: true, if: :password_required?

  store_accessor :settings, :search
  delegate :address, :employment, to: :profile
end
