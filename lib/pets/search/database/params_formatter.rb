class Pets::Search::Database::ParamsFormatter
  def initialize(params)
    @params = params
  end

  attr_reader :params
  
  def execute
    return {} if params.blank?
    params.delete_if { |k, v| v.blank? }
  end
end