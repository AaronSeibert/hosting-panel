json.array!(@service_categories) do |service_category|
  json.extract! service_category, :id, :name
  json.url service_category_url(service_category, format: :json)
end
