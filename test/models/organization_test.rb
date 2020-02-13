require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @organization = build(:organization)
  end

  should have_many(:physical_addresses)
  should have_one(:legal_address)
  should belong_to(:admin)
end
