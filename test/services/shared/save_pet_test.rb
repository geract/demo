require "test_helper"

class SavePetTest < ActiveSupport::TestCase
  VALID_SHORT_URL = /http:\/\/bit\.ly/

  setup do
    @pet = create(:pet, :complete)
    organization = create(:organization, :complete)
    @user = create(:rescuer, :complete, organization: organization)
  end

  def test_rit_sets_pet_short_url_attribute
    assert_nil @pet.short_url
    Shared::SavePet.perform(@pet, @user)

    assert_match VALID_SHORT_URL, @pet.reload.short_url
  end
end
