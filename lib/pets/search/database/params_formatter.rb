class Pets::Search::Database::ParamsFormatter
  def initialize(params)
    @params = params
  end

  attr_reader :params
  
  def execute
    return {} if params.blank?

    db_params = {}
    db_params[:id] = params[:id] if !params[:id].blank?
    db_params[:slug] = params[:slug] if !params[:slug].blank?
    db_params[:status] = params[:status] if !params[:status].blank?
    db_params[:organization_id] = params[:organization_id] if !params[:organization_id].blank?
    db_params
  end
end