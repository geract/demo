# frozen_string_literal: true

class Admin::SaveOrganization
  class << self
    def perform(org)
      @organization = org
      Organization.transaction do
        org_saved = organization.save
        saved_callbacks(organization) if org_saved
        org_saved
      end
    end

    private

    attr_reader :organization

    def saved_callbacks(organization)
      remove_physical_addresseses(organization)
    end

    def remove_physical_addresseses(organization)
      return if organization.foster_based
      organization.physical_addresses.delete_all
    end
  end
end