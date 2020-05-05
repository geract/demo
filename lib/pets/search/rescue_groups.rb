class Pets::Search::RescueGroups
  PETS_PER_PAGE = 20.freeze

  def execute(args)
    params = build_params(args)
    response = RescueGroups::Animal.where(params)
    Pets::Search::RescueGroups::ResponseFormatter.new(response).execute
  end

  private

  def build_params(args)
    params = Pets::Search::RescueGroups::ParamsFormater.new(args).execute
    params.merge({
        species: 'Dog', 
        updated_date: { greater_than: '2020-01-09'}, 
        status: 'Available', 
        start: start_from_record(args['page']),
        limit: records_limit(args['limit']), 
        sort: 'animalLocationDistance'
      })
  end

  def start_from_record(page)
    page = page.to_i
    return 0 unless page > 1
    ( page - 1 ) * PETS_PER_PAGE
  end

  def records_limit(limit)
    limit || PETS_PER_PAGE
  end
end
