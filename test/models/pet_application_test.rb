require 'test_helper'

class PetApplicationTest < ActiveSupport::TestCase
  setup do
    @application = build(:pet_application)
  end

  context 'associations' do
    should belong_to(:adopter)
    should belong_to(:applicationable)

    should have_one(:profile)
    should belong_to(:veterinarian)
    should belong_to(:co_adopter)

    should have_many(:references)

    should accept_nested_attributes_for(:profile)
    should accept_nested_attributes_for(:co_adopter)
    should accept_nested_attributes_for(:applicationable)
    should accept_nested_attributes_for(:pet_info)
    should accept_nested_attributes_for(:veterinarian)
    should accept_nested_attributes_for(:references)
  end
  
  context 'validations' do
    should_not validate_presence_of(:adoption_fee_agreement)
    should_not validate_presence_of(:home_visit_agreement)
  end
  
  def test_it_can_be_saved
    @application.save
  end
end
