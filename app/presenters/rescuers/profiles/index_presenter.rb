module Rescuers
  class Profiles::IndexPresenter
    def initialize(users)
      @users = users
    end

    def as_json(*)
      users.map { |user| Rescuers::Profiles::ShowPresenter.new(user) }
    end

    private

    attr_reader :users
  end
end
