class Shared::SavePet
  class << self
    def perform(pet, user)
      @user = user
      @pet = pet
      Pet.transaction do
        add_user_data_to_pet
        saved = pet.save
        saved_callbacks if saved
        saved
      end
    end

    private

    attr_reader :pet, :user

    def saved_callbacks
      shorten_url
    end

    def add_user_data_to_pet
      pet.added_by = user
      pet.organization = user.organization
    end

    def shorten_url
      if Rails.env.production? || Rails.env.staging?
        ::LinkShortenerJob.perform_later(pet.id)
      else
        ::LinkShortenerJob.perform_now(pet.id)
      end
    end
  end
end
