class RedisClientService
  def initialize
    @redis = $redis
  end

  def set_presigned_url_cache(presigned_url:, key:, file_name:, content_type:)
    cache_key = "presigned-url:#{presigned_url}"
    value = {
      key: key,
      file_name:,
      content_type:
    }
    @redis.set(cache_key, value.to_json, nx: true)
    @redis.expire(cache_key, 3600)
  ensure
    @redis.close
  end

  def get_presigned_url_cache(presigned_url:, key:)
    return nil unless presigned_url.present? && key.present?
    cache_key = "presigned-url:#{presigned_url}"
    value = @redis.get(cache_key)
    JSON.parse(value, symbolize_names: true) if value
  rescue JSON::ParserError
    nil
  ensure
    @redis.close
  end

end
