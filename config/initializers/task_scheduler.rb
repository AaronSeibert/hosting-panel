require 'rubygems'
require 'rufus/scheduler'


if `hostname -f` == 'ewrpweb01a.binaryitsystems.com' || Rails.env == "production"
  scheduler = Rufus::Scheduler.new
  
  scheduler.cron '0 0 * * *' do
      Subscription.create_invoices
  end
end