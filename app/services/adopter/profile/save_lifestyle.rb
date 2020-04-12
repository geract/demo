# frozen_string_literal: true

class Adopter::Application::SaveLifestyle
  attr_reader :application

  def initialize(adopter, params)
    @adopter = adopter
    @application = @adopter.application
    @lifestyle_attributes = params[:applicationable_attributes][:pet_info_attributes]
  end
  
  def perform
    @application.transaction do
      @application.applicationable.tap do |a|
        a.pet_info_attributes = @lifestyle_attributes
      end

      @application.continue_application && @application.continue!
    end
  end
end
