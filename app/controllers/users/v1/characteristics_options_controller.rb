class Users::V1::CharacteristicsOptionsController < Users::BaseController
  def index
    response_with_presenter(options: options)
  end

  private

  def options
    @options ||= CharacteristicsOptionsService.perform('dog')
  end
end
