class Users::V1::OrganizationsController < Users::BaseController
  def show
    organization = RescueGroups::Organization.find(params[:id].to_i).first
    
    pets = Shared::SearchPet.perform(provider: 'RescueOrganization',
                               organization_id: params[:id])

    if organization
      render json: { organization: Organizations::ShowPresenter.new(pets, organization) }, 
                     status: :ok
    else
      render status: 404
    end
  end
end
