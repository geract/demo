require 'test_helper'

class Admin::IndexOrganizationTest < ActionDispatch::IntegrationTest
  def setup
    create(:organization, :complete, name: 'Foster Organization')
    create(:organization, :complete, name: 'Rescuer Organization')

    login_as_admin
    visit admins_organizations_path
  end

  def test_admin_see_all_organizations_by_name
    first_element = page.find(:xpath, '//ul/li[1]/a')
    last_element = page.find(:xpath, '//ul/li[last()]/a')

    assert page.has_content?('Organizations')
    assert first_element.text, 'Foster Organization'
    assert last_element.text,  'Rescuer Organization'
  end

  def test_admin_click_organization_list
    last_element = page.find(:xpath, '//ul/li[last()]/a')
    last_element.click
    organization = page.find('#organization_name').value

    assert page.has_content?('Organization Information')
    assert_equal organization, 'Rescuer Organization'
  end
end
