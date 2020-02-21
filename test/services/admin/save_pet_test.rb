require "test_helper"

class SavePetTest < ActiveSupport::TestCase
  VALID_SHORT_URL = /http:\/\/bit\.ly/

  def test_bitly_url_is_generated_after_performing_save_test
    setup do
      build(:pet).save
    end
  
    def test_it_sets_pet_short_url_attribute
      pet = Pet.last

      assert_nil @pet.short_url
      User::SavePet(pet)

      assert_match VALID_SHORT_URL, @pet.reload.short_url
    end
  end
end
