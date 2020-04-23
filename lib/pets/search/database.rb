class Pets::Search::Database
  def execute(args)
    Pet.where(args)
  end
end
