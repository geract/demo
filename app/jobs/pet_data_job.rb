class PetDataJob < ApplicationJob
  retry_on Exception, wait: 5.minutes, attempts: 3

  def perform(loader:)
    loader.constantize.new.perform
  end
end
