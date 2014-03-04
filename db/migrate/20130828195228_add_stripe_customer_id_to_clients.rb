class AddStripeCustomerIdToClients < ActiveRecord::Migration
  def change
    add_column :clients, :stripe_customer_id, :string
  end
end
