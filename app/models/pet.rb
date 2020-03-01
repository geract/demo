class Pet < ApplicationRecord
  include Pets::StateManager
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :organization
  belongs_to :added_by, class_name: 'User'

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

  has_many_attached :images
  enum reason_code: { pet_adopted: 0, pet_died: 1, no_longer_available: 2 }

  scope :not_archived, -> { where.not(status: 'archived') }

  def long_url
    host = ENV['host'] || Rails.application.config_for(:config)[:bitly][:app_url]
    Rails.application.routes.url_helpers.pet_url(name, host: host)
  end

  def update_short_url(short_url)
    update(short_url: short_url)
  end
end
