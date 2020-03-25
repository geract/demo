require "test_helper"

class PetApplication::DogTest < ActiveSupport::TestCase
  setup do
    @dog = build(:pet_application_dog)
  end

  context 'associations' do
    should have_one(:application)
    should have_one(:pet_info)

    should accept_nested_attributes_for(:pet_info)
  end

  def test_pet_can_be_created
    @dog.save
  end
end
