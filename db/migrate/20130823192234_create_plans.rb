class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :remote_id
      t.decimal :price, :precision => 8, :scale => 2
      t.text :description

      t.timestamps
    end
  end
end
