json.array!(@sites) do |site|
  json.extract! site, :client_id, :description
  json.domain site_domain(site, format: :json)
end
