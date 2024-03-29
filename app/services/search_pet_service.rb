class SearchPetService
  def self.perform(args)
    local_source = Pets::Search::Database.new.execute(args)
    external_source = Pets::Search::RescueGroups.new.execute(args)

    local_source.to_a.concat(external_source)
  end
end