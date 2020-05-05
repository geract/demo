require 'test_helper'

class Admin::CreateOrganizationTest < ActionDispatch::IntegrationTest
  def setup
    login_as_admin
    visit new_admins_organization_url
  end

  def test_admin_creates_organization_with_sheltered
    fill_basic_form
    check 'organization_sheltered'
    click_on 'Save organization'

    org = Organization.last
    basic_asserts(org)
    assert       org.legal_address
    assert_empty org.physical_addresses
    assert       org.rescuer_profile
  end

  def test_admin_creates_organization_without_type
    fill_basic_form
    click_on 'Save organization'

    org = Organization.last
    basic_asserts(org)
    assert       org.legal_address
    assert_empty org.physical_addresses
  end

  def test_admin_creates_organization_with_sheltered
    fill_basic_form
    check 'organization_sheltered'
    click_on 'Save organization'

    org = Organization.last
    basic_asserts(org)
    assert       org.legal_address
    assert_empty org.physical_addresses
  end

  # def test_admin_creates_organization_with_foster_based
  #   fill_basic_form
  #   check 'organization_foster_based'
  #   click_on 'Add physical addresses'
  #   fill_in 'organization_physical_addresses_attributes_0_name', with: 'Testing'
  #   fill_in 'organization_physical_addresses_attributes_0_address', with: '345 Spear St'
  #   fill_in 'organization_physical_addresses_attributes_0_city', with: 'San Francisco'
  #   fill_in 'organization_physical_addresses_attributes_0_state', with: 'California'
  #   fill_in 'organization_physical_addresses_attributes_0_zip_code', with: '94105'
  #   click_on 'Save organization'

  #   org = Organization.last
  #   basic_asserts(org)
  #   assert org.legal_address
  #   assert org.physical_addresses
  # end

  def fill_basic_form
    fill_in 'organization_name', with: 'org'
    fill_in 'organization_director', with: 'isay'
    fill_in 'organization_description', with: 'org description'
    fill_in 'organization_facebook', with: 'https://www.facebook.com/org'
    fill_in 'organization_twitter', with: 'https://www.twitter.com/org'
    fill_in 'organization_instagram', with: 'https://www.instagram.com/org'
    fill_in 'organization_email', with: 'test@gmail.com'
    fill_in 'organization_phone', with: '33776576764575'
    fill_in 'organization_legal_address_attributes_name', with: 'Testing'
    fill_in 'organization_legal_address_attributes_address', with: '345 Spear St'
    fill_in 'organization_legal_address_attributes_city', with: 'San Francisco'
    fill_in 'organization_legal_address_attributes_state', with: 'California'
    fill_in 'organization_legal_address_attributes_zip_code', with: '94105'
    fill_in 'organization_rescuer_admin_profile_attributes_first_name', with: 'Noel'
    fill_in 'organization_rescuer_admin_profile_attributes_last_name', with: 'Brizuela'
    fill_in 'organization_rescuer_admin_profile_attributes_admin_attributes_email', with: 'noel@pph.com'
    fill_in 'organization_rescuer_admin_profile_attributes_phone', with: '3313352255'
    fill_in 'organization_rescuer_admin_profile_attributes_title', with: 'director'
  end

  def basic_asserts(org)
    assert_equal 'org', org.name
    assert_equal 'isay', org.director
    assert_equal 'org description', org.description
    assert_equal 'https://www.facebook.com/org', org.facebook
    assert_equal 'https://www.twitter.com/org', org.twitter
    assert_equal 'https://www.instagram.com/org', org.instagram
  end
end
