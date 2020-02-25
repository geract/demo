require "test_helper"

class PetShowTest < ActiveSupport::TestCase
  def test_bitly_url_is_generated_after_performing_save_test
    setup do
      build(:pet).save
    end
  
    def test
      pet = create(:pet, status: 'archived', reason_code: 'pet_died')
    
      response, status = Pet::Show.perform(pet)
      
      assert_response :gone
      assert api_response.include?('errors')
      assert_includes api_response['errors'].first, 'Doggo is no longer available. Look for more pets like Doggo'
    end
  end
end
