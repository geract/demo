require "test_helper"

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = build(:admin)
  end

  should have_many(:organizations)
end
