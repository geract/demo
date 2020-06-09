class Users::V1::Rescuers::Organizations::ShowPresenter < BasePresenter
  def as_json(*)
    {
      organization: {
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
        legal_address: Users::V1::Objects::RescuerAddressPresenter.to_json(organization.legal_address),
        physical_addresses: organization.physical_addresses.map do|address|
          Users::V1::Objects::RescuerAddressPresenter.to_json(address)
        end
      }
    }
  end
end