require 'test_helper'

class LinkShortenerJobrailsTest < ActiveJob::TestCase
  include ActiveJob::TestHelper

  setup do
    build(:pet).save
  end

  def test_it_updates_pet_short_url_attribute
    @pet = Pet.last
    
    assert_enqueued_jobs 1 do
      LinkShortenerJob.perform_later(@pet.id)
    end
  end
end
