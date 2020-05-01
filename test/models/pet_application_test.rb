require "test_helper"

class PetApplicationTest < ActiveSupport::TestCase
  def setup
    @pet_application = build(:pet_application, organization: build(:organization))
  end

  context 'associations' do
    should belong_to(:pet)
    should belong_to(:adopter_profile)
    should belong_to(:organization)
  end

  def test_it_can_be_saved
    assert @pet_application.save
  end
end
