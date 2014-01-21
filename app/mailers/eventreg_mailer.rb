class EventregMailer < ActionMailer::Base
  default from: "Diversity Day Registrar <mailer@diversity.stratosphe.re>"

  def late_email(user)
    @user = user
    mail(to: user.email, subject: "RJ Diversity Day Registration Closing")
  end

  def register_confirmation_email(user)
    @user = user
    mail(to: user.email, subject: "RJ Diversity Day Registration Confirmation")
  end

  def admin_blast_email(user, subject, body)
    @user = user
    @body = body
    mail(to: user.email, subject: subject)
  end

  def open_email(user)
    @user = user
    mail(to: user.email, subject: "RJ Diversity Day Registration Now Open")
  end

end
