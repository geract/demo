class Pets::Search::RescueGroups::ParamsFormater
  def initialize(params)
    @params = params
  end

  attr_reader :params
  
  def execute
    return {} if params.blank?
    {
      id: params[:id],
      location: params[:location],
      location_distance: params[:radius],
      breed: params[:breed],
      general_size_potential: params[:size],
      sex: params[:sex], 
      general_age: params[:age]
    }.compact
  end
end
