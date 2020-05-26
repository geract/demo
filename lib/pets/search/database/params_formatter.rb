class Pets::Search::Database::ParamsFormatter
  def initialize(params)
    @params = params
  end

  attr_reader :params
  
  def execute
    return {} if params.blank?
    
    db_params = {}
    db_params[:id] = params[:id] if !params[:id].blank?
    db_params[:breed] = params[:breed] if !params[:breed].blank?
    db_params[:size] = params[:size] if !params[:size].blank?
    db_params[:sex] = params[:sex] if !params[:sex].blank?
    db_params[:general_age] = params[:age] if !params[:age].blank?
    db_params[:organization_id] = params[:organization_id] if !params[:organization_id].blank?
    db_params
  end
end