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
        self.plans.each do |p|
          if p.interval == "month" and p.interval_count == 1
            amount += p.price
          end
        end
      when "biannual"
        self.plans.each do |p|
        if p.interval == "month" and p.interval_count == 6
          amount += p.price
        end
      end
      when "annual"
        self.plans.each do |p|
        if p.interval == "year"
          amount += p.price
        end
      end
    end
    return amount
  end
end
