class AddSiteIdToSubscription < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :site, index: true
  end
end
