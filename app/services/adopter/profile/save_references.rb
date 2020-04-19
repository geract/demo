# frozen_string_literal: true

class Adopter::Profile::SaveReferences
  class << self
    MIN_REFERENCES = 1

    def perform(profile, params)
      @profile = profile

      profile.assign_attributes(params)
      profile.transaction do
        saved = profile.save
        saved_callbacks if saved
        saved
      end
    end

    def saved_callbacks
      profile.add_references? && profile.continue!
    end

    private

    attr_reader :profile
  end
end
