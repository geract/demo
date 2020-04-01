class Admin::InviteRescuer
  class << self
    def perform(user_id, token)
      rescuer = Rescuer.find(user_id)

      Tracker.identify(rescuer)
      Tracker.track(
        rescuer,
        event: 'Rescuer User Invited',
        properties: {
          invitation_url: invitation_url(token),
          first_name: rescuer.profile.first_name,
          last_name: rescuer.profile.last_name
        }
      )

      rescuer_user.touch :confirmed_at
    end

    private

    def invitation_url(token)
      "#{Rails.application.config_for(:config)[:segment][:app_url]}/auth/confirmation/#{token}"
    end
  end
end
