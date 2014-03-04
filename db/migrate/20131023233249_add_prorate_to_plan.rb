class AddProrateToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :prorate, :boolean
  end
end
