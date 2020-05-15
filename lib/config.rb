class Config
  class << self
    def settings_for(name)
      Rails.application.config_for("settings/#{name.to_s}")
    end
  end
end