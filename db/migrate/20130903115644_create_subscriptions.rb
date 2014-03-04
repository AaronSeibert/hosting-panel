class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :client, index: true
      t.references :plan, index: true
      t.date :next_bill_date

      t.timestamps
    end
  end
end
