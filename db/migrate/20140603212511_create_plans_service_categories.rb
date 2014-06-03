class CreatePlansServiceCategories < ActiveRecord::Migration
  def change
    create_table :plans_service_categories, :id => false do |t|
      t.references :service_category
      t.references :plan
    end
  end
end
