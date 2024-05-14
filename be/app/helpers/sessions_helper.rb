module SessionsHelper
  require 'net/http'
  require 'uri'
  def set_cookies(key, value, exp)
    cookies[key] = {
      value:,
      expires: exp,
      httponly: true,
      secure: false
    }
  end
end
