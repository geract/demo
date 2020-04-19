require "test_helper"

class PetInfoTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:adopter_profile)
  end

  context 'stores' do
    should respond_to?(:home)
    should respond_to?(:personal)
    should respond_to?(:lifestyle)
    should respond_to?(:animal_history)
    should respond_to?(:veterinarian_extra)
  end

  def test_it_can_be_saved
    @adopter = build(:adopter)
    @pet_info = build(:pet_info, adopter_profile: @adopter.profile)

    assert @pet_info.valid?
  end
end
