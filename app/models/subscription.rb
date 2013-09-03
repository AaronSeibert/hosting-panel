class Subscription < ActiveRecord::Base
  belongs_to :client
  belongs_to :plan
  
  def self.create_invoices
    # For testing only!!!
    # End Testing
    
    @subscriptions = Subscription.where(next_bill_date: Date.parse("01-01-2014"))
    @clients = @subscriptions.map{|c| c.client}.uniq
    
    # Loop through each subscription that rebills today, create a Stripe invoice item
    @subscriptions.each do |s|
      if s.last_invoiced != s.next_bill_date
        begin
          Stripe::InvoiceItem.create(
            :customer => s.client.stripe_customer_id,
            :amount => (s.plan.price*100).floor,
            :currency => "usd",
            :description => s.plan.description
          )
          s.last_invoiced = Date.today
          s.next_bill_date = s.plan.next_bill_date
          s.save
        rescue Exception => exc
          logger.error("Oh no! There was an error adding the invoice item: #{exc.message}")
        end
      end
    end
    @clients.each do |c|
      begin
        invoice = Stripe::Invoice.create(
          :customer => c.stripe_customer_id
        )
        invoice.pay
      rescue Exception => exc
        logger.error("Oh no! There was an error creating the invoice: #{exc.message}")
      end
    end
  end
end
