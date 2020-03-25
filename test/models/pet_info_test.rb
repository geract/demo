require "test_helper"

class PetInfoTest < ActiveSupport::TestCase
  setup do
    @pet_info = build(:pet_info)
  end

  context 'stores' do
    should respond_to?(:home)
    should respond_to?(:personal)
    should respond_to?(:lifestyle)
    should respond_to?(:animal_history)
    should respond_to?(:veterinarian_extra)
  end

  def test_it_can_be_saved
    assert @pet_info.valid?
  end
end
