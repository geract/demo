require "test_helper"

class RescuerProfileTest < ActiveSupport::TestCase
  should belong_to(:rescuer)
  should belong_to(:organization)

  should validate_presence_of :first_name
  should validate_presence_of :last_name
end