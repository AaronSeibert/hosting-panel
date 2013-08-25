json.array!(@urls) do |url|
  json.extract! url, :ulr, :site_id, :ssl_enabled
  json.url url_url(url, format: :json)
end
