module ImagePath
  extend ActiveSupport::Concern

  class_methods do 
    def image_field_name(field)
      define_method(:images_url) do
        images = send(field)

        return images if images.empty?

        if Rails.env.production? || Rails.env.staging?
          images.map(&:service_url)
        else
          images.map do |image|
            Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
          end
        end
      end
    end
  end
end
