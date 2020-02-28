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

  def test_pet_can_be_published
    assert_equal @pet.status, 'created'

    @pet.publish

    assert_equal @pet.status, 'published'
  end

  def test_new_pet_can_be_archived
    assert_equal @pet.status, 'created'

    status_updated = Pet::UpdateStatus.perform(@pet, 'archive', reason_code: 'pet_adopted')

    assert status_updated
    assert_equal @pet.status, 'archived'
  end

  def test_not_archived_scope
    archived_pet = create(:pet, status: 'archived', reason_code: 'pet_died')

    assert_includes Pet.all, archived_pet
    assert_not_includes Pet.not_archived, archived_pet
  end

  def test_not_archived_scope
    archived_pet = create(:pet, status: 'archived', reason_code: 'pet_died')

    assert_includes Pet.all, archived_pet
    assert_not_includes Pet.not_archived, archived_pet
  end
end
