class Organization < ApplicationRecord
  belongs_to :admin
  has_many :organization_addresses

  accepts_nested_attributes_for :organization_addresses
end
