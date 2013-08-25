json.array!(@plans) do |plan|
  json.extract! plan, :remote_id, :price, :description
  json.url plan_url(plan, format: :json)
end
