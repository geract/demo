class Users::V1::Objects::RescuerProfilePresenter
  class << self
    def to_json(current_user)
      {
        id: current_user.profile.id,
        first_name: current_user.profile.first_name,
        last_name: current_user.profile.last_name,
        phone: current_user.profile.phone,
        title: current_user.profile.title,
        email: current_user.email,
        status: current_user.status,
        photo: profile_photo(current_user.profile)
      }
    end

    private

    def profile_photo(profile)
      return '' unless profile.photo.attached?

      if Rails.env.production? || Rails.env.staging?
        profile.photo.service_url
      else
        Rails.application.routes.url_helpers.rails_blob_url(profile.photo, only_path: true)
      end
    end
  end
end