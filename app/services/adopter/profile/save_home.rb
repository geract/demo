# frozen_string_literal: true

class Adopter::Profile::SaveHome
  class << self
    def perform(profile, params)
      @profile = profile

      profile.assign_attributes(params)
      profile.transaction do
        saved = profile.save
        saved_callbacks if saved
        saved
      end
    end
    
    private

    def saved_callbacks
      profile.home? && profile.continue!
    end

    attr_reader :profile
  end
end
