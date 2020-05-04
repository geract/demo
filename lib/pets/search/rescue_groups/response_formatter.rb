class Pets::Search::RescueGroups::ResponseFormatter
  def initialize(response)
    @response = response
  end
  
  def execute
    return response if response.blank?

    response.map { |k, v| Pets::Search::RescueGroups::ResponseAdapter.new(v) }
  end

  private

  attr_reader :response
end
