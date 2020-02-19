require 'test_helper'

class Admin::UpdateOrganizationTest < ActionDispatch::IntegrationTest
  def setup
    organization = create(:organization, :complete, name: "Happy feed org")
    login_as_admin
    visit admins_organization_path(organization)
  end

  def test_admin_updates_an_organization
    fill_in 'organization_name', with: 'Happy paws org'
    fill_in 'organization_director', with: 'Jane D'
    fill_in 'organization_description', with: 'org description'
    fill_in 'organization_facebook', with: 'https://www.facebook.com/org'
    fill_in 'organization_twitter', with: 'https://www.twitter.com/org'
    fill_in 'organization_instagram', with: 'https://www.instagram.com/org'
    click_on 'Update Organization'

    organization = Organization.last

    assert_equal organization.name, 'Happy paws org'
    assert_equal organization.director, 'Jane D'
    assert_equal organization.description, 'org description'
    assert_equal organization.facebook, 'https://www.facebook.com/org'
    assert_equal organization.twitter, 'https://www.twitter.com/org'
    assert_equal organization.instagram, 'https://www.instagram.com/org'
  end
end
