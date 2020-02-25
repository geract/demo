class LinkShortenerJob < ApplicationJob
  queue_as :default
  after_perform { pet.update_short_url(short_url) }

  def perform(pet_id)
    @pet = Pet.find(pet_id)
    @short_url = LinkShortener.new.shorten(pet.long_url)
  end

  private

  attr_reader :short_url, :pet
end
