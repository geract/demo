class Users::V1::Rescuers::Rescuers::ShowPresenter < BasePresenter
  def as_json(*)
    {
      rescuer: Users::V1::Objects::RescuerProfilePresenter.to_json(rescuer)
    }
  end
end