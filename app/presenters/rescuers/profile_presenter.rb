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
        photo: (profile.photo.attached? ? Rails.application.routes.url_helpers.rails_blob_url(profile.photo, only_path: true) : '')
      }
    end

    private

    attr_reader :profile
  end
end
