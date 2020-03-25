require "test_helper"

class AdopterProfileTest < ActiveSupport::TestCase
  setup do
    @adopter_profile = build(:adopter_profile)
  end

  context 'associations' do
    should have_one(:address)
    should have_one(:employment)
    
    should belong_to(:adopter)

    should accept_nested_attributes_for(:address)
    should accept_nested_attributes_for(:employment)
  end

  context 'validations' do
    should validate_presence_of(:phone_number)
    should validate_presence_of(:adopter)
  end

  def test_pet_can_be_created
    @adopter_profile.save
  end
end
