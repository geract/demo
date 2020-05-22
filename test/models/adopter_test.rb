require 'test_helper'

class AdopterTest < ActiveSupport::TestCase
  setup do
    @adopter = build(:adopter)
  end

  context 'associations' do
    should have_one(:profile)
    should have_many(:pet_applications)

    should have_many(:favorites)
    should have_many(:favorite_pets)

    should accept_nested_attributes_for(:profile)
  end

  context 'validations' do
    should validate_presence_of(:password)
  end
  
  def test_is_valid
    assert @adopter.valid?
  end
end
