class Pet < ApplicationRecord
  store_accessor :personality, :good_with_dogs
  store_accessor :personality, :good_with_cats
  store_accessor :personality, :good_with_children

  validates :price, presence: true
  validates :description, presence: true
  validates :breed, presence: true
  validates :sex, presence: true
  validates :size, presence: true
  validates :age, presence: true
  validates :name, presence: true

  has_many_attached :images

end
