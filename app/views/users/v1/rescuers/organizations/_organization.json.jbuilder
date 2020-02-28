json.organization do
  json.id           @organization.id
  json.name         @organization.name
  json.director     @organization.director
  json.description  @organization.description
  json.facebook     @organization.facebook
  json.twitter      @organization.twitter
  json.instagram    @organization.instagram
  json.n5013c       @organization.send(:'5013c')
  json.sheltered    @organization.sheltered
  json.foster_based @organization.foster_based
  json.url          @organization.url
  json.email        @organization.email
  json.phone        @organization.phone
  json.legal_address do
    json.partial! partial: 'address', address: @organization.legal_address
  end
  json.physical_addresses do
    json.partial! partial: 'address', collection: @organization.physical_addresses, as: :address
  end
end
