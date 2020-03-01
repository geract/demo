require "test_helper"

class SavePetTest < ActiveSupport::TestCase
  VALID_SHORT_URL = /http:\/\/bit\.ly/

  setup do
    @pet = create(:pet, :complete)
  end

  def test_it_sets_pet_short_url_attribute
    assert_nil @pet.short_url
    User::SavePet.perform(@pet)

    assert_match VALID_SHORT_URL, @pet.reload.short_url
  end
end
