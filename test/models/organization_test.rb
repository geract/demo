require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @organization = build(:organization)
  end

  should have_many(:physical_addresses)
  should have_one(:legal_address)
  should belong_to(:admin)

  def test_organization_by_name
    admin = create(:admin)
    a_organization = create(:organization, :complete, name: 'a', admin: admin)
    aa_organization = create(:organization, :complete, name: 'aa', admin: admin)
    z_organization = create(:organization, :complete, name: 'z', admin: admin)

    assert_equal Organization.by_name, [a_organization, aa_organization, z_organization]
  end
end
