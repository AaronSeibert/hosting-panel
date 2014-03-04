class AddLastInvoicedToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_invoiced, :date
  end
end
