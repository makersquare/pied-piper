class UserMailer < ActionMailer::Base
  default from: "notifications@makersquare.com"

  def welcome_email(user)
    @user = user
    @url = 'http://makersquare.com/crm/admin'
    mail(to: @user.email, subject: 'Welcome to Pied Piper CRM')
  end

  def email_update

  end
end
