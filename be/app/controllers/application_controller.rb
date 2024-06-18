class ApplicationController < ActionController::API
  include ActionController::Cookies
  include Api::V1::RescueExceptions
  before_action :set_locale

  private

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale] || I18n.default_locale
    # I18n.locale = I18n.default_locale unless I18n.available_locales.include?(I18n.locale.to_sym)
  end
end
