# frozen_string_literal: true

class Adopter::Application::SavePersonalFinal
  attr_reader :application

  def initialize(adopter, params)
    @adopter = adopter
    @application = @adopter.application
    @veterinarian_attributes = params[:veterinarian_attributes]
    @applicationable_attributes = params[:applicationable_attributes]
  end

  def perform
    @application.transaction do
      @application.assign_attributes(attributes)
      @application.applicationable = applicationable

      @application.veterinarian = nil unless veterinarian?

      @application.continue_application && @application.save
    end
  end

  private

  def attributes
    { veterinarian_attributes: @veterinarian_attributes }
  end

  def applicationable
    @application.applicationable.tap do |a|
      a.pet_info_attributes = @applicationable_attributes[:pet_info_attributes]
    end
  end

  def veterinarian?
    @application.applicationable.pet_info.veterinarian_extra[:has_veterinarian]
  end
end
