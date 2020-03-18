module Rescuers
  class ProfilePresenter
    def initialize(profile)
      @profile = profile
    end

    def response
      {
        first_name: profile.first_name,
        last_name: profile.last_name,
        phone: profile.phone,
        title: profile.title
      }
    end

    private

    attr_reader :profile
  end
end
