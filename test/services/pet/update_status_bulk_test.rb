require "test_helper"

class Pet::UpdateStatusBulkTest < ActiveSupport::TestCase
  def test_it_updates_several_records_statuses
    user = create(:rescuer_admin, :complete)
    create(:pet, :complete, name: 'Perro', added_by: user)
    create(:pet, :complete, name: 'Chien', added_by: user)

    pets, errors = Pet::UpdateStatusBulk.perform(Pet.ids, 'publish')

    assert_equal Pet.first.status, 'published'
    assert_equal Pet.last.status, 'published'
  end
end
