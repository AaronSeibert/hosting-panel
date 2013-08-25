class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.references :client, index: true
      t.references :plan, index: true
      t.text :description

      t.timestamps
    end
  end
end
