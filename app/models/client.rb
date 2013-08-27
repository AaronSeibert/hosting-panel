class Client < ActiveRecord::Base
  has_many :sites, dependent: :destroy
  has_many :domains, through: :sites

  validates :name, presence: true
  def Client.monthly_report
    ReportMailer.monthly_report.deliver
  end
end
