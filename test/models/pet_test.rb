require 'test_helper'

class PetTest < ActiveSupport::TestCase
  def setup
    @pet = build(:pet)
  end

  should validate_presence_of :description
  should validate_presence_of :breed
  should validate_presence_of :sex
  should validate_presence_of :size
  should validate_presence_of :age
  should validate_presence_of :price
  should validate_presence_of :name
  should validate_presence_of :status

  def test_new_pet_can_be_archived
    assert_equal @pet.status, 'created'

    @pet.archive

    assert_equal @pet.status, 'archived'
  end
  
  def test_pet_is_invalid_if_it_is_archived_without_reason_code
    assert @pet.reason_code.nil?
    assert_not_includes @pet.errors[:reason_code], 'can\'t be blank'

    @pet.archive

    refute @pet.valid?
    assert_includes @pet.errors, :reason_code
    assert_includes @pet.errors[:reason_code], 'can\'t be blank'
  end
end
