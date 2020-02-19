# frozen_string_literal: true
class Admin::SaveRescuerAdmin
  class << self
    def perform(rescuer_admin)
      @rescuer_admin = rescuer_admin
      RescuerAdmin.transaction do
        saved = rescuer_admin.save
        saved_callbacks if saved
        saved
      end
    end

    private

    attr_reader :rescuer_admin

    def saved_callbacks
      reset_password_and_send_invitation
    end

    def reset_password_and_send_invitation
      rescuer_admin.allow_password_change = true
      token = rescuer_admin.password_token
      Admin::InviteRescuerAdmin.perform(rescuer_admin.id, token)
    end
  end
end
