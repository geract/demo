# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.class == User
      cannot :manage, Organization
    end

    if user.class == RescuerAdmin
      can :update, Organization
      can :read, Organization
      can :manage, Pet
    end
  end
end
