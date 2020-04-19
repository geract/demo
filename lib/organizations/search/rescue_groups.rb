class Organizations::Search::RescueGroups
  PETS_PER_PAGE = 20.freeze

  def execute(args)
    response = RescueGroups::Organization.find(args[:id].to_i).first
    Organizations::Search::RescueGroups::ResponseAdapter.new(response)
  end
end