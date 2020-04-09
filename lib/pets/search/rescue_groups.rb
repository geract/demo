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

  ANIMAL_STATUS = %w(available foster returned hold pending sponsorship intake).freeze

  def build_params(args)
    params = Pets::Search::RescueGroups::ParamsFormater.new(args).execute
    params.merge({ species: 'Dog', limit: 20, sort: 'breedName', status: ANIMAL_STATUS })
  end
end
