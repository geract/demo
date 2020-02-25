require "test_helper"

class RescuerTest < ActiveSupport::TestCase
  def setup
    @user = build(:rescuer)
  end

  def test_set_password
    Rails.application.stub(:credentials, OpenStruct.new(rescuer_admin_default_password: 'iFyRAB53n')) {}

    @user.password = 'The test'
    @user.valid?
    assert @user.password, 'iFyRAB53n'
  end
end
