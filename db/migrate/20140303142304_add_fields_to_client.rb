class AddFieldsToClient < ActiveRecord::Migration
  def change
    add_column :clients, :address_one, :string
    add_column :clients, :address_two, :string
    add_column :clients, :city, :string
    add_column :clients, :state, :string
    add_column :clients, :zip, :string
    add_column :clients, :billing_email, :string
    add_column :clients, :contact_name, :string
  end
end
