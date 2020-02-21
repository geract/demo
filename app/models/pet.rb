class Pet < ApplicationRecord
  include Pets::StateManager
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
  validates :status, presence: true
  validates :reason_code, presence: true, if: ->(user) { user.status == 'archived' }

  has_many_attached :images
  enum reason_code: { pet_adopted: 0, pet_died: 1, no_longer_available: 2 }

  def long_url
    host = ENV['host'] || "http://www.petparenthub.dev.com"
    Rails.application.routes.url_helpers.users_pet_url(name, host: host)
  end

  def update_short_url(short_url)
    update(short_url: short_url)
  end
end
