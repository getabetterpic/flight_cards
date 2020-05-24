class Mailer < ApplicationMailer
  def send_csv(csv, options = {})
    to = options[:to] || 'dan@danandjensmith.com'
    subject = options[:subject] || 'Data Export'
    attachments['data.csv'] = csv
    mail(to: to, subject: subject)
  end
end
