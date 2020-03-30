# frozen_string_literal: true

class User::Adopter::Application::SavePersonalCoAdopter
  attr_reader :application

  def initialize(adopter, params)
    @adopter = adopter
    @application = @adopter.application

    return false unless params[:co_adopter_attributes].present?

    @co_adopter_attributes = params[:co_adopter_attributes].merge(password: generate_password)
    @co_adopter_attributes[:profile_attributes][:is_from_co_adopter] = true

    @is_address_same_as_adopter = params[:is_address_same_as_adopter]
    @applicationable_attributes = params[:applicationable_attributes]
  end
  
  def perform
    @application.transaction do
      @application.assign_attributes(attributes)
      @application.applicationable = applicationable

      @application.co_adopter.profile.address = @adopter.address if @is_address_same_as_adopter

      employment = @application.co_adopter.profile.employment
      employment.skip_costs_for_co_adopter = employment.without_address?

      @application.continue_application && @application.save
    end
  end

  private

  def attributes
    attrs = {
      co_adopter_attributes: @co_adopter_attributes,
    }
  end

  def applicationable
    @application.applicationable.tap do |a|
      a.pet_info_attributes = @applicationable_attributes[:pet_info_attributes]
    end
  end

  def generate_password
    verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)
    verifier.generate("#{Time.now}").first(20)
  end
end
