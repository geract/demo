require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @organization = build(:organization, :admin)
  end

  def organization_address_association
    must have_many :physical_addresses
    must have_one :legal_address
  end
end
