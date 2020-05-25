class Users::V1::Organizations::ShowPresenter < BasePresenter
  def as_json(*)
    {
      organization: OrganizationObjectPresenter.to_json(organization)
    }
  end
end