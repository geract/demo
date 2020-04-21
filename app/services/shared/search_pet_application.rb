class Shared::SearchPetApplication
  def self.perform(args)
    Pet.where(args)
  end
end
