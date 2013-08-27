class Client < ActiveRecord::Base
  has_many :sites, dependent: :destroy
  has_many :domains, through: :sites

  def Client.monthly_report
    ReportMailer.monthly_report.deliver
  end
end
