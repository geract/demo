require "test_helper"

class PhysicalAddressTest < ActiveSupport::TestCase
  def setup
    @physical = build(:physical_addresses, :admin)
  end

  def physical_address_association
    must belong_to :organization
  end
end
