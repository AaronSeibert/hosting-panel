class Site < ActiveRecord::Base
  belongs_to :client
  has_many :urls
  has_one :plan
end
