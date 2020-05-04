class Pets::Search::Database::ParamsFormatter
  def initialize(params)
    @params = params
  end

  attr_reader :params
  
  def execute
    return {} if params.blank?

    db_params = {}
    db_params[:status] = params[:status] unless params[:status].blank?
    db_params[:organization_id] = params[:organization_id] unless params[:organization_id].blank?
    db_params
  end
end