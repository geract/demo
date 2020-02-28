require "test_helper"

class RescuerAdminProfileTest < ActiveSupport::TestCase
  should belong_to(:rescuer)

  should validate_presence_of :first_name
  should validate_presence_of :last_name
  should validate_presence_of :phone
end