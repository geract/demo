class Users::V1::Rescuers::Profiles::ShowPresenter < BasePresenter
  def as_json(*)
    Users::V1::Objects::RescuerProfilePresenter.to_json(current_user)
  end
end