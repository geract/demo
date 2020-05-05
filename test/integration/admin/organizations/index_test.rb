require 'test_helper'

class Admin::IndexOrganizationTest < ActionDispatch::IntegrationTest
  def setup
    create(:organization, :complete, name: 'Foster Organization')
    create(:organization, :complete, name: 'Rescuer Organization')

    login_as_admin
    visit admins_organizations_path
  end

  def test_admin_see_all_organizations_by_name
    assert page.has_content?('Organizations')
    assert page.has_link?('Foster Organization')
    assert page.has_link?('Rescuer Organization')
  end
end

