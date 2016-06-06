class ApplicationMailer < ActionMailer::Base
  default from: %("Beigel Website" <web@beigel.com.ar>)
  layout 'mailer'
end
