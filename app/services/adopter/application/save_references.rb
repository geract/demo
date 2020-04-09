# frozen_string_literal: true

class Adopter::Application::SaveReferences
  MIN_REFERENCES = 3

  attr_reader :application

  def initialize(adopter, params)
    @adopter = adopter
    @application = adopter.application
    @references_attributes = params[:references_attributes]
  end

  def perform
    @application.assign_attributes(attributes)

    @application.transaction do
      if MIN_REFERENCES > @application.references.size
        @application.errors.add(:references, "must be at least #{MIN_REFERENCES}")
        return false
      end

      save_references? && @application.continue!
    end
  end

  private

  def attributes
    { references_attributes: @references_attributes }
  end

  def request_references_feedback
    @application.references.each do |reference|
      Users::Adopters::RequestReferenceFeedback.perform_later(reference)
    end
  end
  
  def save_references?
    @application.references.all?(&:valid?) && @application.save
  end
end
