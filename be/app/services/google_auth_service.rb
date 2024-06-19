require 'singleton'
class GoogleAuthService
  include Singleton
  def initialize
    @client_id = ENV.fetch('GG_CLIENT_ID', nil)
    @client_secret = ENV.fetch('GG_CLIENT_SECRET', nil)
    @redirect_uri = ENV.fetch('GG_OAUTH_REDIRECT_URL', nil)
    @grant_type = 'authorization_code'
  end

  def google_user_info(access_token)
    url = URI.parse(Settings.gg_oauth.userinfo_url + access_token)
    response = make_request(url, :get, {'Authorization' => "Bearer #{access_token}"})

    raise Errors::Api::Unauthorized unless response.is_a?(Net::HTTPSuccess)

    return JSON.parse(response.body, symbolize_names: true)
  end

  private

  def make_request(url, method, headers = {}, body = nil)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true if url.scheme == 'https'

    request = case method
              when :get
                Net::HTTP::Get.new(url.request_uri, headers)
              when :post
                req = Net::HTTP::Post.new(url.request_uri, headers)
                req.set_form_data(body) if body
                req
              end
    http.request(request)
  end
end
