class Users::V1::Organizations::ShowPresenter < BasePresenter
  def as_json(*)
    {
      organization: Users::V1::Objects::OrganizationPresenter.to_json(organization)
    }
  end
end