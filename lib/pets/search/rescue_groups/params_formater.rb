class Pets::Search::RescueGroups::ParamsFormater
  def initialize(params)
    @params = params
  end

  attr_reader :params
  
  def execute
    return {} if params.blank?

    rg_params = {}
    rg_params[:id] = params[:id] if params[:id]
    rg_params[:location] = params[:zipCode] if params[:zipCode]
    rg_params[:location_distance] = params[:radius] if params[:radius] && params[:zipCode]
    rg_params[:breed] = params[:breed] if params[:breed]
    rg_params[:general_size_potential] = params[:size] if params[:size]
    rg_params[:sex] = params[:sex] if params[:sex]
    rg_params[:age] = params[:age] if params[:age]
    rg_params
  end
end
