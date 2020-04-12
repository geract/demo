# frozen_string_literal: true

class Adopter::Profile::SavePersonalInfo
  attr_reader :application

  def initialize(adopter, params)
    @adopter = adopter
    @profile_attributes = params[:profile_attributes].merge(id: @adopter.profile.id)
    @applicationable_attributes = params[:applicationable_attributes]
    @has_co_adopter = params[:has_co_adopter]
  end

  def perform
    @adopter.transaction do
      if @adopter.application.present?
        @application = @adopter.application
        @application.assign_attributes(attributes)
      else
        @application = ::PetApplication.new(initialize_attributes)
      end

      @application.applicationable = applicationable

      @application.transaction do
        if @profile_attributes[:pronoun].blank? || @profile_attributes[:family_status].blank?
          @application.errors.add(:pronoun, "can't be blank") if @profile_attributes[:pronoun].blank?
          @application.errors.add(:family_status, "can't be blank") if @profile_attributes[:family_status].blank?
          return false
        end

        @has_co_adopter && @application.continue_application! || @application.skip_co_adopter!
        @application.save
      end
    end
  end

  private

  def initialize_attributes
    {
      adopter: @adopter,
      profile_attributes: @profile_attributes,
    }
  end

  def attributes
    {
      profile_attributes: @profile_attributes
    }
  end

  def applicationable
    return PetApplication::Dog.new(@applicationable_attributes) unless @application.applicationable
    @application.applicationable.tap { |a| a.assign_attributes(@applicationable_attributes) }
  end
end
