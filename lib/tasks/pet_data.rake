namespace :pet_data do
  desc 'Load pet data from different resources'
  task load: :environment do
    # every loader(ex. PetData::RescueGroups::Loader)
    # has to be performed in it's own job execution
    # ex. if we add a new loader called 'xxxx'
    # add another line with
    # PetDataJob.perform_later(xxxx)
    PetDataJob.perform_later(loader: 'PetData::RescueGroups::Loader')
  end
end
