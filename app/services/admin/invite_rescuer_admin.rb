# frozen_string_literal: true

class Admin::InviteRescuerAdmin
  def self.perform(admin_id, token)
    rescuer_admin = RescuerAdmin.find(admin_id)

    Tracker.identify(rescuer_admin, token)
    Tracker.track(
      rescuer_admin,
      event: 'Rescuer Invited',
      properties: {
        token: token
      }
    )

    rescuer_admin.touch :confirmed_at
  end
end
