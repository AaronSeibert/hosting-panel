json.array!(@plans) do |plan|
  json.extract! plan, :remote_id, :price, :description
  json.domain plan_domain(plan, format: :json)
end
