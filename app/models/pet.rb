class Pet < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

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

  def long_url
    host = ENV['host'] || "http://www.petparenthub.dev.com"
    Rails.application.routes.url_helpers.users_pet_url(name, host: host)
  end

  def update_short_url(short_url)
    update(short_url: short_url)
  end
end
