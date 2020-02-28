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

  def test_rescuer_scope_by_name
    albert = create(:rescuer, first_name: 'Albert')
    claudia = create(:rescuer, first_name: 'Claudia')
    xavier = create(:rescuer, first_name: 'Xavier')

    assert_equal Rescuer.by_name, [albert, claudia, xavier]
  end

  def test_rescuer_scope_by_status
    albert = create(:rescuer, first_name: 'Albert', status: 'activated')
    claudia = create(:rescuer, first_name: 'Claudia', status: 'archived')
    xavier = create(:rescuer, first_name: 'Xavier', status: 'activated')

    assert_equal Rescuer.by_name_and_status('activated'), [albert, xavier]
  end
end
