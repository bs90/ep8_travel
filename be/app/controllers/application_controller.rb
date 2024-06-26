class ApplicationController < ActionController::API
  include ActionController::Cookies
  include Api::V1::BaseConcern
  before_action :set_locale

  private

  def set_locale
    accepted_language = request.headers['Accept-Language']
    if accepted_language.present?
      preferred_locale = accepted_language.scan(/^[a-z]{2}/).first&.to_sym
      I18n.locale = I18n.available_locales.include?(preferred_locale) ? preferred_locale : I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end
  end
end
