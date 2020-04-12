require "test_helper"

class AdopterAddressTest < ActiveSupport::TestCase
  setup do
    @adopter = build(:adopter)
    @address = build(:adopter_address, addressable: @adopter.profile)
  end

  context 'validations' do
    should validate_presence_of(:street_line_1)
    should_not validate_presence_of(:street_line_2)
    should validate_presence_of(:city)
    should validate_presence_of(:state)
    should validate_presence_of(:zip_code)
    should validate_presence_of(:country)
  end

  def test_it_can_be_saved
    assert @address.valid?
  end
end
