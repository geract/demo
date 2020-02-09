module PetData::RescueGroups
  class Formater
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def perform
      data.map { |_id, data_row| format_data_row(data_row) }
    end

    private

    def format_data_row(data_row)
      {
        name: data_row['animalName'],
        external_id: data_row['animalID'],
        external_type: 'RescueGroups',
        pet_type: data_row['animalSpeciesID']
      }
    end
  end
end