require 'test_helper'

class VeterinarianTest < ActiveSupport::TestCase
  context 'associations' do
    should have_one(:address)

    should belong_to(:adopter_profile)

    should accept_nested_attributes_for(:address)
  end

  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should validate_presence_of(:phone_number)
    should validate_presence_of(:address)
  end

  def test_should_save
    @adopter = build(:adopter)
    @veterinarian = build(:veterinarian, adopter_profile: @adopter.profile)

    assert @veterinarian.save
  end
end
