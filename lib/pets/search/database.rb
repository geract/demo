class Pets::Search::Database
  attr_accessor :filters

  def initialize(**args)
    @filters = args
  end

  def execute
    Pet.where(filters)
  end
end
