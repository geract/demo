require "test_helper"

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = build(:admin)
  end

  test "it should send and email after Rescuer Admin is invited" do
    @admin = RescuerAdmin.create(admin_params)

    
  end

  should have_many(:organizations)

  private

  def admin_params(attrs = {})
    {
      email: "test@admin.com",
      password: "topsecret",
      type: "RescuerAdmin"
    }.merge(attrs)
  end
end
