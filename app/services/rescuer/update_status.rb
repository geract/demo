class Rescuer::UpdateStatus
  def self.perform(rescuer, status)
    rescuer.send("#{status}!")
  end
end
