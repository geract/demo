class Admins::OrganizationsController < Admins::BaseController
  def index
    @organizations = Organization.by_name
  end

  def new
    @organization = Organization.new
    @organization.build_legal_address
    @organization.build_rescuer_admin_profile
    @organization.rescuer_admin_profile.build_admin
  end

  def create
    @organization = Organization.new(organization_params)
    
    if Admin::SaveOrganizationService.perform(@organization)
      flash[:notice] = 'Organization successfully created'
      redirect_to admins_organization_path(@organization)
    else
      flash[:error] = 'There was an error creating the organization'
      render :new
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      redirect_to admins_organization_path(@organization)
    else
      render :show
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  private

  def organization_params
    params.require(:organization).permit( :name,
                                          :director,
                                          :description,
                                          :facebook,
                                          :twitter,
                                          :instagram,
                                          :'5013c',
                                          :url,
                                          :email,
                                          :phone,
                                          :sheltered,
                                          :foster_based,
                                          :logo,
                                          legal_address_attributes: organization_addresses_attributes,
                                          physical_addresses_attributes: organization_addresses_attributes,
                                          rescuer_admin_profile_attributes: [:first_name, :last_name, :title, :phone, 
                                            admin_attributes: [:email]
                                          ])
  end

  def organization_addresses_attributes
    %i(id name address city state zip_code main_location)
  end

  def create_organization
    @organization = Organization.new(organization_params)
    @organization.admin_id = current_admin.id
    @organization.save
  end
end
