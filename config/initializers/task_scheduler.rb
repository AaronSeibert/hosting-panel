require 'rubygems'
require 'rufus/scheduler'
  
scheduler = Rufus::Scheduler.new

scheduler.cron '0 0 1 * *' do
    Subscription.create_invoices
end