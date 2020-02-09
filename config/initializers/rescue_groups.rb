RescueGroups.configuration do |config|
  config.apikey = Rails.application.credentials.rescue_groups_key
  config.load_all_results = true
  config.raw_data = true
end