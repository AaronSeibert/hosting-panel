class AddMultipleToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :multiple, :boolean, :default => false
  end
end
