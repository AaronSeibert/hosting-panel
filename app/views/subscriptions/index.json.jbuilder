json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :client_id, :description
  json.url subscription_url(subscription, format: :json)
end
