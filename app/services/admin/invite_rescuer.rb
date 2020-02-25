class Admin::InviteRescuer
  def self.perform(user_id, token)
    rescuer = Rescuer.find(user_id)

    Tracker.identify(rescuer, token)
    Tracker.track(
      rescuer,
      event: 'Rescuer User Invited',
      properties: {
        token: token
      }
    )

    rescuer_user.touch :confirmed_at
  end
end
