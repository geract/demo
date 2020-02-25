class Pet::Search
  def self.perform(**args)
    if args[:provider] == 'RescueOrganization'
      searcher = Pets::Search::RescueGroups.new(args)
    else
      searcher = Pets::Search::Database.new(args)
    end

    searcher.execute
  end
end
