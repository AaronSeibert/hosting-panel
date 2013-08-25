class Client < ActiveRecord::Base
  has_many :sites, dependent: :destroy
  has_many :urls, through: :sites
end
