class Pets::Search::RescueGroups::ResponseFormater
  def initialize(response)
    @response = response
  end
  
  def execute
    return response if response.blank?

    response.map { |k, v| Pets::Search::RescueGroups::ResponseAdopter.new(v) }
  end

  private

  attr_reader :response
end