class Pets::Search::RescueGroups
  attr_accessor :params

  def initialize(args)
    @params = build_params(args)
  end

  def execute
    response = RescueGroups::Animal.where(params)
    Pets::Search::RescueGroups::ResponseFormater.new(response).execute
  end

  private

  def build_params(args)
    params = Pets::Search::RescueGroups::ParamsFormater.new(args).execute
    params.merge(base_params)
  end

  def base_params
    {
      species: 'Dog', 
      updated_date: { greater_than: '2020-01-09'}, 
      status: 'Available', 
      limit: 100, 
      sort: 'animalLocationDistance'
    }
  end
end
