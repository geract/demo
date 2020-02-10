class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
    @organization.organization_addresses.build
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.save
    redirect_to @organization
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
                                          organization_address_attributes: organization_address_attributes )
  end

  def organization_address_attributes
    %i[name address city state zip_code main_location]
  end
end
