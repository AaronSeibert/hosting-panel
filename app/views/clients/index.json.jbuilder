json.array!(@clients) do |client|
  json.extract! client, :name
  json.domain client_domain(client, format: :json)
end
