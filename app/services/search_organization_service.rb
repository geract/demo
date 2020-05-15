class SearchOrganizationService
  def self.perform(args)
    if args[:provider] == 'RescueOrganization'
      searcher = Organizations::Search::RescueGroups.new
    end

    searcher.execute(args)
  end
end