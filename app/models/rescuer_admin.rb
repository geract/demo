class RescuerAdmin < User
  def send_confirmation_instructions
    Admin::InviteRescuerAdmin.perform(self.id)
  end
end
