require "test_helper"

class Rescuer::ShowPetTest < ActiveSupport::TestCase
  def test_success_response
    @pet = create(:pet, :complete)

    response, status = Rescuer::ShowPet.perform(@pet)

    assert_equal status, :ok
    assert response[:errors].empty?
    assert response[:pet].present?
    assert response[:pet][:name], @pet.name
  end

  def test_gone_response
    @pet = create(:pet, :complete, status: 'archived', reason_code: 'pet_died')

    response, status = Rescuer::ShowPet.perform(@pet)

    assert_equal status, :gone
    assert_includes response[:errors], "#{@pet.name} is no longer available. Look for more pets like #{@pet.name}"
    assert response[:pet].empty?
  end
end
