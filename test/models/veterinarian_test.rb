require 'test_helper'

class VeterinarianTest < ActiveSupport::TestCase
  setup do
    @veterinarian = build(:veterinarian)
  end

  context 'associations' do
    should have_one(:address)

    should accept_nested_attributes_for(:address)
  end

  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should validate_presence_of(:phone_number)
  end

  def test_should_save
    assert @veterinarian.save
  end
end
