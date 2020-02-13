class Organization < ApplicationRecord
  belongs_to :admin
  has_one :legal_address
  has_many :physical_addresses

  accepts_nested_attributes_for :legal_address, :physical_addresses, update_only: true

  scope :by_name, -> { order(:name) }
end
