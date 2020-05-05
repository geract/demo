class Pet < ApplicationRecord
  include Pets::StateManager
  include ImagePath
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :organization
  belongs_to :added_by, class_name: 'User'
  has_many :applications, class_name: 'PetApplication'
  has_and_belongs_to_many :favorites, -> { distinct }, join_table: 'favorites', class_name: 'User'

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
  image_field_name :images

  enum reason_code: { pet_adopted: 0, pet_died: 1, no_longer_available: 2 }

  scope :not_archived, -> { where.not(status: 'archived') }
  scope :by_status, -> (status) { where(status: status) }
  scope :remove_filters, -> () { unscope(:where) }

  def date_listed
    @date_listed ||= applications.order(:created_at).first.try(:created_at)
  end

  def long_url
    host = ENV['host'] || Rails.application.config_for(:config)[:bitly][:app_url]
    Rails.application.routes.url_helpers.pet_url(name, host: host)
  end

  def update_short_url(short_url)
    update(short_url: short_url)
  end
end
