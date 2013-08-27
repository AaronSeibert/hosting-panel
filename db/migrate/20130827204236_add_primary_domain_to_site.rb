class AddPrimaryDomainToSite < ActiveRecord::Migration
  def change
    add_column :sites, :primary_domain_id, :integer, :unique => true, :index => true
  end
end
