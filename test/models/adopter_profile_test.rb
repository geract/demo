require "test_helper"

class AdopterProfileTest < ActiveSupport::TestCase
  setup do
    @adopter_profile = build(:adopter_profile)
  end

  context 'associations' do
    should have_one(:address)
    should have_one(:employment)
    should have_one(:pet_info)
    
    should belong_to(:adopter)
    should belong_to(:co_adopter)
    should belong_to(:veterinarian)
    should belong_to(:applicationable)

    should accept_nested_attributes_for(:co_adopter)
    should accept_nested_attributes_for(:applicationable)
    should accept_nested_attributes_for(:pet_info)
    should accept_nested_attributes_for(:veterinarian)
    should accept_nested_attributes_for(:references)
    should accept_nested_attributes_for(:address)
    should accept_nested_attributes_for(:employment)
  end

  context 'validations' do
    should validate_presence_of(:phone_number)
    should validate_presence_of(:adopter)

    should_not validate_presence_of(:adoption_fee_agreement)
    should_not validate_presence_of(:home_visit_agreement)
  end

  def test_pet_can_be_created
    @adopter_profile.save
  end
end
