class Users::V1::Rescuers::Rescuers::IndexPresenter < BasePresenter
  def as_json(*)
    {
      rescuers: rescuers.map{ |rescuer| Users::V1::Objects::RescuerProfilePresenter.to_json(rescuer) }
    }
  end
end