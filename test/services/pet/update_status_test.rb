require "test_helper"

class UpdateStatusTest < ActiveSupport::TestCase
  setup do
    @pet = create(:pet)
  end

  def test_it_updates_user_status_and_reason_code
    assert_equal @pet.status, 'created'
    assert_nil @pet.reason_code

    Pet::UpdateStatus.perform(@pet, 'archive', reason_code: 'pet_adopted')

    assert_equal @pet.status, 'archived'
    assert_equal @pet.reason_code, 'pet_adopted'
  end
end
