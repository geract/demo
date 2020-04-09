# frozen_string_literal: true

class Adopter::Application::SaveHome
  attr_reader :application

  def initialize(adopter, params)
    @adopter = adopter
    @application = @adopter.application
    @home_attributes = params[:applicationable_attributes][:pet_info_attributes][:home]
  end

  def perform
    @application.transaction do
      @application.applicationable.tap do |a|
        a.pet_info_attributes = @home_attributes
      end

      @application.continue_application && @application.save
    end
  end
end
