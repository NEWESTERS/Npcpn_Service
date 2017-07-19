class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = browser_locales.first || I18n.default_locale
  end

  private def browser_locales
    request.env['HTTP_ACCEPT_LANGUAGE'].split(/;|,/).reject do |x|
      x.start_with?('q')
    end & I18n.available_locales.map(&:to_s)
  end
end
