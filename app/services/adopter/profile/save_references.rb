# frozen_string_literal: true

class Adopter::Profile::SaveReferences
  MIN_REFERENCES = 3

  attr_reader :profile

  def initialize(adopter, params)
    @profile = adopter.profile
    @attributes = params
  end

  def perform
    profile.assign_attributes(attributes)

    profile.transaction do
      if MIN_REFERENCES > profile.references.size
        profile.errors.add(:references, "must be at least #{MIN_REFERENCES}")
        return false
      end

      profile.add_references? && profile.continue!
      save_references?
    end
  end

  private

  attr_reader :attributes

  def request_references_feedback
    @profile.references.each do |reference|
      Users::Adopters::RequestReferenceFeedback.perform_later(reference)
    end
  end
  
  def save_references?
    @profile.references.all?(&:valid?) && @profile.save
  end
end
