class Organization < ApplicationRecord
  belongs_to :admin
  has_many :organization_addresses
end
