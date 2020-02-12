require "test_helper"

class LegalAddressTest < ActiveSupport::TestCase
  def setup
    @legal = build(:legal_addresses, :admin)
  end

  def legal_address_association
    must belong_to :organization
  end
end
