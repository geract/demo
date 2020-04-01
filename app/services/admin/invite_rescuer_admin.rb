# frozen_string_literal: true

class Admin::InviteRescuerAdmin
  class << self
    def perform(admin_id, token)
      rescuer_admin = RescuerAdmin.find(admin_id)

      Tracker.identify(rescuer_admin)
      Tracker.track(
        rescuer_admin,
        event: 'Rescuer Invited',
        properties: {
          invitation_url: invitation_url(token),
          first_name: rescuer_admin.profile.first_name,
          last_name: rescuer_admin.profile.last_name
        }
      )

      rescuer_admin.touch :confirmed_at
    end

    private

    def invitation_url(token)
      "#{Rails.application.config_for(:config)[:segment][:app_url]}/auth/confirmation/#{token}"
    end
  end
end
