json.array!(@sites) do |site|
  json.extract! site, :client_id, :description
  json.url site_url(site, format: :json)
end
