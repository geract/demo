class Users::V1::OrganizationsController < Users::BaseController
  def show
    filters = filters_params.merge({ provider: 'RescueOrganization' })
    organization = SearchOrganizationService.perform(filters)

    response_with_presenter(organization: organization)
  end

  def filters_params
    params.permit(:id)
  end
end
