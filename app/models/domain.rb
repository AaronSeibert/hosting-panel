class Domain < ActiveRecord::Base
  belongs_to :site
  
  validates :url, presence: true
end
