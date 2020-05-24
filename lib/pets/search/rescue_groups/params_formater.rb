class Pets::Search::RescueGroups::ParamsFormater
  def initialize(params)
    @params = params
  end

  attr_reader :params
  
  def execute
    return {} if params.blank?

    rg_params = {}
    rg_params[:id] = params[:id] if !params[:id].blank?
    rg_params[:location] = params[:zipCode] if !params[:zipCode].blank?
    rg_params[:location_distance] = { radius: params[:radius] } if !params[:radius].blank? && !params[:zipCode].blank?
    rg_params[:breed] = params[:breed] if !params[:breed].blank?
    rg_params[:general_size_potential] = params[:size] if !params[:size].blank?
    rg_params[:sex] = params[:sex] if !params[:sex].blank?
    rg_params[:general_age] = params[:age] if !params[:age].blank?
    rg_params[:organization_id] = params[:organization_id] if !params[:organization_id].blank?
    rg_params
  end
end
