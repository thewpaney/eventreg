class EventregMailer < ActionMailer::Base
  default from: "diversity.mailer@gmail.com"
  
  def open_email(recipient)
    mail(to: recipient.email, subject: "RJHS Diversity Day Registration Now Open!")
  end

  def custom_email(recipient, title, body)
    @title = title
    @body = body
    mail(to: recipient.email, subject: "#{title}")
  end

  def late_email(recipient)
    
  end

  def register_confirmation_email(recipient)
    
  end

end
