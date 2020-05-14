class Rescuer::UpdateStatusService
  def self.perform(rescuer, status)
    rescuer.send("#{status}!")
  end
end
