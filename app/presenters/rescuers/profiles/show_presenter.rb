module Rescuers
  class Profiles::ShowPresenter
    def initialize(user)
      @user = user
    end

    def as_json(*)
      response = Rescuers::ProfilePresenter.new(user.profile).response
      response.merge({
        email: user.email,
        status: user.status
      })
    end

    private

    attr_reader :user
  end
end
