class Site < ActiveRecord::Base
  belongs_to :client
  has_many :domains
  has_one :plan

  accepts_nested_attributes_for :domains
end
