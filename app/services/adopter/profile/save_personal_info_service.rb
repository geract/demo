# frozen_string_literal: true

class Adopter::Profile::SavePersonalInfoService
  class << self
    def perform(profile, params)
      @profile = profile

      profile.assign_attributes(params)
      profile.transaction do
        before_save_callbacks
        saved = profile.save
        saved_callbacks if saved
        saved
      end
    end

    private

    attr_reader :profile, :has_co_adopter

    def before_save_callbacks
      @has_co_adopter = ActiveModel::Type::Boolean.new.cast(profile.has_co_adopter)
      # Destroy co_adopter if exists, otherwise set the empty object passed through params as nil
      unless has_co_adopter
        profile.co_adopter&.destroy || profile.co_adopter = nil
      end
    end

    def saved_callbacks
      update_profile_state
    end

    def update_profile_state
      return true unless profile.personal_info?
      return profile.skip_co_adopter! unless has_co_adopter
      profile.continue!
    end
  end
end
