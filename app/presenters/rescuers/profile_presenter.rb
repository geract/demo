module Rescuers
  class ProfilePresenter
    def initialize(profile)
      @profile = profile
    end

    def response
      {
        id: profile.id,
        first_name: profile.first_name,
        last_name: profile.last_name,
        phone: profile.phone,
        title: profile.title,
        photo: profile_photo
      }
    end

    private

    attr_reader :profile

    def profile_photo
      return '' unless profile.photo.attached?

      if Rails.env.production?
        profile.photo.service_url
      else
        Rails.application.routes.url_helpers.rails_blob_url(profile.photo, only_path: true)
      end
    end
  end
end
