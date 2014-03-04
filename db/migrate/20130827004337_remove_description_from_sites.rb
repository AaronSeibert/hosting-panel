class RemoveDescriptionFromSites < ActiveRecord::Migration
  def change
    remove_column :sites, :description, :text
  end
end
