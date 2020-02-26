require "test_helper"

class Pet::UpdateBulkTest < ActiveSupport::TestCase
  def test_it_updates_several_records_statuses
    create(:pet, name: 'Perro')
    create(:pet, name: 'Chien')

    pets, errors = Pet::UpdateBulk.perform(Pet.ids, 'publish')

    assert_equal Pet.first.status, 'published'
    assert_equal Pet.last.status, 'published'
  end
end
