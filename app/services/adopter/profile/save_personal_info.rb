# frozen_string_literal: true

class Adopter::Profile::SavePersonalInfo
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
      update_profile_state
    end

    def update_profile_state
      return unless profile.personal_info?
      return profile.skip_co_adopter! unless profile.has_co_adopter
      profile.continue!
    end
  end
end
