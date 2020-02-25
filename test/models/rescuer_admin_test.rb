require "test_helper"

class RescuerAdminTest < ActiveSupport::TestCase
  def setup
    @admin = build(:rescuer_admin)
  end

  def test_set_password
    Rails.application.stub(:credentials, OpenStruct.new(rescuer_admin_default_password: 'iFyRAB53n')) {}

    @admin.password = 'The test'
    @admin.valid?
    assert @admin.password, 'iFyRAB53n'
  end
end
