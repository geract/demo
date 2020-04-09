class Pets::Search::RescueGroups::ParamsFormater
  def initialize(params)
    @params = params
  end

  attr_reader :params
  
  def execute
    return {} if params.blank?

    rg_params = {}
    rg_params[:id] = params[:id] unless params[:id].blank?
    rg_params[:location] = params[:zipCode] unless params[:zipCode].blank?
    rg_params[:location_distance] = params[:radius] unless params[:radius].blank? || params[:zipCode].blank?
    rg_params[:breed] = params[:breed] unless params[:breed].blank?
    rg_params[:general_size_potential] = params[:size] unless params[:size].blank?
    rg_params[:sex] = params[:sex] unless params[:sex].blank?
    rg_params[:age] = params[:age] unless params[:age].blank?
    rg_params[:organization_id] = params[:organization_id] unless params[:organization_id].blank?
    rg_params
  end
end
