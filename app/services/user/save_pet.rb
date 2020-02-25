class User::SavePet
  class << self
    def perform(pet)
      @pet = pet
      Pet.transaction do
        saved = pet.save
        saved_callbacks if saved
        saved
      end
    end

    private

    attr_reader :pet

    def saved_callbacks
      shorten_url
    end
    
    def shorten_url
      if Rails.env.production?
        ::LinkShortenerJob.perform_later(pet.id)
      else
        ::LinkShortenerJob.perform_now(pet.id)
      end
    end
  end
end
