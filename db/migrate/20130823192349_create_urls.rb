class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :ulr
      t.references :site, index: true
      t.boolean :ssl_enabled

      t.timestamps
    end
  end
end
