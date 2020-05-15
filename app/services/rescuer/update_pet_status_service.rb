class Rescuer::UpdatePetStatusService
  def self.perform(pet, status, params = {})
    case status
    when 'archive'
      pet.reason_code = params[:reason_code]
    end

    pet.send("#{status}!")
  end
end
