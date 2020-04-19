class Organizations::ShowPresenter
  def initialize(organization)
    @organization = organization
  end

  def as_json(*)
    OrganizationPresenter.new(organization).response
  end

  private

  attr_reader :organization
end