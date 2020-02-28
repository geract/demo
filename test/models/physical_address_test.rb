require "test_helper"

class PhysicalAddressTest < ActiveSupport::TestCase
  def setup
    @physical = build(:legal_address)
  end

  should belong_to :organization
end
