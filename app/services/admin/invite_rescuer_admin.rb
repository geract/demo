# frozen_string_literal: true

class Admin::InviteRescuerAdmin
  def self.perform(admin_id)
    rescuer_admin = RescuerAdmin.find(admin_id)

    Tracker.identify(rescuer_admin)
    Tracker.track(
      rescuer_admin,
      event: 'Rescuer Invited',
      properties: {
        confirmation_token: rescuer_admin.confirmation_token
      }
    )

    rescuer_admin.touch :confirmed_at
  end
end
