json.array!(@domains) do |domain|
  json.extract! domain, :domain, :site_id, :ssl_enabled
  json.domain domain_domain(domain, format: :json)
end
