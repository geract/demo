require 'test_helper'

class PetTest < ActiveSupport::TestCase
  def setup
    @pet = build(:pet, :complete)
  end

  should belong_to(:organization)
  should belong_to(:added_by)
  should have_many(:applications)

  should validate_presence_of :description
  should validate_presence_of :breed
  should validate_presence_of :sex
  should validate_presence_of :size
  should validate_presence_of :age
  should validate_presence_of :price
  should validate_presence_of :name
  should validate_presence_of :status
  should validate_presence_of :location
  should have_and_belong_to_many :favorites

  def test_pet_can_be_published
    assert_equal @pet.status, 'created'

    @pet.publish

    assert_equal @pet.status, 'published'
  end

  def test_new_pet_can_be_archived
    assert_equal @pet.status, 'created'

    status_updated = Rescuer::UpdatePetStatus.perform(@pet, 'archive', reason_code: 'pet_adopted')

    assert status_updated
    assert_equal @pet.status, 'archived'
  end

  def test_not_archived_scope
    archived_pet = create(:pet, :complete, status: 'archived', reason_code: 'pet_died')

    assert_includes Pet.all, archived_pet
    assert_not_includes Pet.not_archived, archived_pet
  end
end
