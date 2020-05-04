class Pets::Search::Database
  def execute(args)
    params = Pets::Search::Database::ParamsFormatter.new(args).execute
    Pet.where(params)
  end
end
