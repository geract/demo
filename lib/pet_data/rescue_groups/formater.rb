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
      # note: this is a temporary import data
      {
        name: data_row['animalName'],
        external_id: data_row['animalID'],
        external_type: 'RescueGroups',
        price: validate_field(data_row['animalAdoptionFee']).to_i,
        description: data_row['animalID'],
        breed: data_row['animalBreed'],
        sex: data_row['animalSex'],
        size: 'small',
        age: data_row['animalGeneralAge']
      }
    end

    def validate_field(value)
      return nil if value.blank?
    end
  end
end