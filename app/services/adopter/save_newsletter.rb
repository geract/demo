class Adopter::SaveNewsletter
  class << self
    def perform(newsletter)
      @newsletter = newsletter
      newsletter.transaction do
        saved = newsletter.save
        saved_callbacks if saved
        saved
      end
    end

    private

    attr_reader :newsletter

    def saved_callbacks
      send_newsletter_welcome_email
    end
    
    def send_newsletter_welcome_email
      Tracker.identify(newsletter)
      Tracker.track(
        newsletter,
        event: 'Newsletter subscribtion',
      )
    end
  end
end
