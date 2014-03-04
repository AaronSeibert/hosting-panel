class Client < ActiveRecord::Base
  has_many :sites, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :plans, through: :subscriptions
  
  validates :name, presence: true
  
  attr_accessor :stripe_card_token
  
  def self.monthly_report
    ReportMailer.monthly_report.deliver
  end
  
  def billing_amount(interval)
    amount = 0   
    
    case interval
      when "month"
        self.subscriptions.each do |s|
          if s.plan.interval == "month" and s.plan.interval_count == 1
            amount += (s.plan.price * s.quantity)
          end
        end
      when "biannual"
        self.subscriptions.each do |s|
        if s.plan.interval == "month" and s.plan.interval_count == 6
          amount += (s.plan.price * s.quantity)
        end
      end
      when "annual"
        self.subscriptions.each do |s|
        if s.plan.interval == "year"
          amount += (s.plan.price * s.quantity)
        end
      end
    end
    return amount
  end

  def get_remote_cards
    if self.stripe_customer_id
      return Stripe::Customer.retrieve(self.stripe_customer_id).cards
    end
  end
  
  def card
    if self.stripe_customer_id
      c = Stripe::Customer.retrieve(self.stripe_customer_id)
      card = c.cards.retrieve(c.default_card)
    end
  end
end
