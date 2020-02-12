require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @admin = build(:admin)
  end

  def test_association
    must have_one :organization
  end
end
