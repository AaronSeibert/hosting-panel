class Site < ActiveRecord::Base
    
  has_many :domains, dependent: :destroy
  has_one :subscription, dependent: :destroy
  
  belongs_to :client
  belongs_to :plan


  accepts_nested_attributes_for :domains
  validates_associated :domains
  
  def cost
    self.plan.price
  end
  
  def interval
    self.plan.interval
  end
  
  def interval_amount
    self.plan.interval_amount
  end
  
  def primary_domain
    self.domains.first.url
  end
end
