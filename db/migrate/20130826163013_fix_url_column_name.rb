class FixUrlColumnName < ActiveRecord::Migration
  def change
    rename_column :urls, :ulr, :url
  end
end
