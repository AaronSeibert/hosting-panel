class ReportMailer < ActionMailer::Base
  default from: ""

  def monthly_report
    mail(to: "", subject: "Binary IT Systems Hosting - Monthly Report")
  end
end
