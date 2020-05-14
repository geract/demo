# frozen_string_literal: true

class Admin::SaveOrganizationService
  class << self
    def perform(org)
      @organization = org
      Organization.transaction do
        org_saved = organization.save
        saved_callbacks if org_saved
        org_saved
      end
    end

    private

    attr_reader :organization

    def saved_callbacks
      remove_physical_addresseses
      reset_password_and_send_invitation_to_admin
    end

    def remove_physical_addresseses
      return if organization.foster_based
      organization.physical_addresses.delete_all
    end

    def reset_password_and_send_invitation_to_admin
      rescuer_admin = organization.admin

      rescuer_admin.allow_password_change = true
      token = rescuer_admin.password_token
      Admin::InviteRescuerAdminService.perform(rescuer_admin.id, token)
    end
  end
end