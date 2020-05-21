class Rescuer::UpdatePetApplicationStatusService
  def self.perform(pet_application, params = {})
    case params[:status]
    when 'reject'
      pet_application.rejection_details = params[:rejection_details]
    end

    pet_application.send("#{params[:status]}!")
  end
end
