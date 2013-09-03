require 'rubygems'
require 'rufus/scheduler'
  
scheduler = Rufus::Scheduler.start_new

scheduler.cron '0 0 1 * *' do
    Subscription.create_invoices
end