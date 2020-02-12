require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @organization = build(:organization)
  end

  def test_associations
    assert_difference '@organization.physical_addresses.count', 2 do
      create(:physical_address, organization: @organization)
    end

    legal_address = create(:legal_address, organization: @organization)
    assert_equal @organization.legal_address.id, legal_address.id
  end
end
