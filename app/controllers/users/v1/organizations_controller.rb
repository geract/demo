class Users::V1::OrganizationsController < Users::BaseController
  def show
    filters = filters_params.merge({ provider: 'RescueOrganization' })

    organization = Shared::SearchOrganization.perform(filters)

    if organization
      render json: { organization: Organizations::ShowPresenter.new(organization) }, 
                     status: :ok
    else
      render status: 404
    end
  end

  def filters_params
    params.permit(:id)
  end
end
