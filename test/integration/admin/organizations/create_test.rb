require 'test_helper'

class Admin::CreateOrganizationTest < ActionDispatch::IntegrationTest
  def setup
    login_as_admin
    visit admin_root_path
  end

  def test_admin_creates_an_organization
    fill_in 'organization_name', with: 'org'
    fill_in 'organization_director', with: 'isay'
    fill_in 'organization_description', with: 'org description'
    fill_in 'organization_facebook', with: 'https://www.facebook.com/org'
    fill_in 'organization_twitter', with: 'https://www.twitter.com/org'
    fill_in 'organization_instagram', with: 'https://www.instagram.com/org'
    click_on 'Create Organization'

    assert_equal Organization.last.name, 'org'
    assert_equal Organization.last.director, 'isay'
    assert_equal Organization.last.description, 'org description'
    assert_equal Organization.last.facebook, 'https://www.facebook.com/org'
    assert_equal Organization.last.twitter, 'https://www.twitter.com/org'
    assert_equal Organization.last.instagram, 'https://www.instagram.com/org'
  end
end
