class Subscription < ActiveRecord::Base
  belongs_to :client
  belongs_to :plan
  belongs_to :site
  
  attr_accessor :bill_now
  
  validates_presence_of :client
  
  def recurring_cost
    plan.price * quantity
  end
  
  def add_invoice_item
    Stripe::InvoiceItem.create(
      :customer => self.client.stripe_customer_id,
      :amount => (self.plan.prorated_charge*100*self.quantity).floor,
      :currency => "usd",
      :description => self.plan.description + " - " + self.description + " - Pro-rated Charge"
    )
  end
  
  def create_invoice
    invoice = Stripe::Invoice.create(
      :customer => @subscription.client.stripe_customer_id
    )
  end
  
  def pay_invoice()
      invoice.pay
      @subscription.last_invoiced = Date.today
      @subscription.save
  end
  
  def self.create_invoices
    # For testing only!!!
    # End Testing
    
    @subscriptions = Subscription.where(next_bill_date: Date.today)
    @clients = @subscriptions.map{|c| c.client}.uniq
    
    # Loop through each subscription that rebills today, create a Stripe invoice item
    @subscriptions.each do |s|
      if s.last_invoiced != s.next_bill_date
        begin
          Stripe::InvoiceItem.create(
            :customer => s.client.stripe_customer_id,
            :amount => (s.plan.price*100*s.quantity).floor,
            :currency => "usd",
            :description => s.plan.description + " - " + s.description
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