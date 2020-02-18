require 'test_helper'

class Admin::CreateOrganizationTest < ActionDispatch::IntegrationTest
  def setup
    login_as_admin
    visit new_admins_organization_url
  end

  def test_admin_creates_organization_with_sheltered
    fill_basic_form
    check 'organization_sheltered'
    click_on 'Create Organization'

    basic_asserts
    assert       Organization.last.legal_address
    assert_empty Organization.last.physical_addresses
  end

  def test_admin_creates_organization_without_type
    fill_basic_form
    fill_in 'organization_physical_addresses_attributes_0_name', with: 'Testing'
    fill_in 'organization_physical_addresses_attributes_0_address', with: '345 Spear St'
    fill_in 'organization_physical_addresses_attributes_0_city', with: 'San Francisco'
    fill_in 'organization_physical_addresses_attributes_0_state', with: 'California'
    fill_in 'organization_physical_addresses_attributes_0_zip_code', with: '94105'
    click_on 'Create Organization'

    basic_asserts
    assert       Organization.last.legal_address
    assert_empty Organization.last.physical_addresses
  end

  def test_admin_creates_organization_with_sheltered
    fill_basic_form
    check 'organization_sheltered'
    click_on 'Create Organization'

    basic_asserts
    assert       Organization.last.legal_address
    assert_empty Organization.last.physical_addresses
  end

  def test_admin_creates_organization_with_foster_based
    fill_basic_form
    check 'organization_foster_based'
    fill_in 'organization_physical_addresses_attributes_0_name', with: 'Testing'
    fill_in 'organization_physical_addresses_attributes_0_address', with: '345 Spear St'
    fill_in 'organization_physical_addresses_attributes_0_city', with: 'San Francisco'
    fill_in 'organization_physical_addresses_attributes_0_state', with: 'California'
    fill_in 'organization_physical_addresses_attributes_0_zip_code', with: '94105'
    click_on 'Create Organization'

    basic_asserts
    assert Organization.last.legal_address
    assert Organization.last.physical_addresses
  end

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
  end

  def basic_asserts
    assert_equal Organization.last.name, 'org'
    assert_equal Organization.last.director, 'isay'
    assert_equal Organization.last.description, 'org description'
    assert_equal Organization.last.facebook, 'https://www.facebook.com/org'
    assert_equal Organization.last.twitter, 'https://www.twitter.com/org'
    assert_equal Organization.last.instagram, 'https://www.instagram.com/org'
  end
end
