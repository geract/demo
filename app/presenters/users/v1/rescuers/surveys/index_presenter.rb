class Users::V1::Rescuers::Surveys::IndexPresenter < BasePresenter
  def as_json(*)
    {
      survey: survey
    }
  end
end
