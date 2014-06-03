class AddAutoBillToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :auto_bill, :boolean
  end
end
