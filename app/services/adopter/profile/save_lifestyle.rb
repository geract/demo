# frozen_string_literal: true

class Adopter::Profile::SaveLifestyle
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

    attr_reader :profile

    def saved_callbacks
      profile.lifestyle? && profile.continue!
    end
  end
end
