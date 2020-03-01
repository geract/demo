require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @organization = build(:organization, :complete)
  end

  should have_many(:pets)
  should have_many(:rescuer_profiles)
  should have_many(:rescuers)
  should have_one(:rescuer_admin_profile)
  # should have_one(:rescuer_admin)
  should have_many(:physical_addresses)
  should have_one(:legal_address)

  validate_presence_of(:name)
  validate_presence_of(:director)
  validate_presence_of(:email)
  validate_presence_of(:phone)
  validate_presence_of(:legal_address)

  def test_validate_organization_type
    organization = create(:organization, :complete, sheltered: false, foster_based: false)
    assert organization.sheltered

    organization.update(foster_based: true)
    assert organization.foster_based
  end

  def test_invalid_physical_addresses?
    organization = create(:organization, :complete, physical_addresses: [], foster_based: true)

    assert_equal ["A physical addresses must be entered."], organization.errors['base']
  end

  def test_organization_by_name
    a_organization = create(:organization, :complete, name: 'a')
    aa_organization = create(:organization, :complete, name: 'aa')
    z_organization = create(:organization, :complete, name: 'z')

    assert_equal Organization.by_name, [a_organization, aa_organization, z_organization]
  end
end
