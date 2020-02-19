class Admins::OrganizationsController < Admins::BaseController
  def index
    @organizations = Organization.by_name
  end

  def new
    @organization = Organization.new
    @organization.physical_addresses.build
    @organization.build_legal_address
  end

  def create
    @organization = Organization.new(organization_params)
    if Admin::SaveOrganization.perform(@organization)
      redirect_to admins_organization_path(@organization)
    else
      render :new
    end
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
                                          physical_addresses_attributes: organization_addresses_attributes)
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
