class Shared::SearchPet
  def self.perform(args)
    if args[:provider] == 'RescueOrganization'
      searcher = Pets::Search::RescueGroups.new
    else
      searcher = Pets::Search::Database.new
    end

    searcher.execute(args)
  end
end
