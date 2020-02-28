require "test_helper"

class LegalAddressTest < ActiveSupport::TestCase
  def setup
    @legal = build(:legal_address)
  end

  should belong_to :organization
end
