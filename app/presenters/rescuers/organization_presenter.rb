module Rescuers
  class OrganizationPresenter
    def initialize(organization)
      @organization = organization
    end

    def response
      {
        id:           organization.id,
        name:         organization.name,
        director:     organization.director,
        description:  organization.description,
        facebook:     organization.facebook,
        twitter:      organization.twitter,
        instagram:    organization.instagram,
        '5013c':      organization['5013c'],
        sheltered:    organization.sheltered,
        foster_based: organization.foster_based,
        url:          organization.url,
        email:        organization.email,
        phone:        organization.phone,
        legal_address: Rescuers::AddressPresenter.new(organization.legal_address).response,
        physical_addresses: organization.physical_addresses.map do|address|
          Rescuers::AddressPresenter.new(address).response
        end
      }
    end

    private

    attr_reader :organization
  end
end
