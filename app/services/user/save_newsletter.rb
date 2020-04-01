class User::SaveNewsletter
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
      send_welcome_email
    end
    
    def send_welcome_email
      # Pending
    end
  end
end
