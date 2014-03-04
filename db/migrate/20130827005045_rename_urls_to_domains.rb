class RenameUrlsToDomains < ActiveRecord::Migration
  def self.up
    rename_table :urls, :domains
  end
  
  def self.down
    rename_table :domains, :urls
  end
end
