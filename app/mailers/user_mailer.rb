class UserMailer < ActionMailer::Base
  default from: "notifications@makersquare.com"

  def welcome_email(user)
    @user = user
    @url = 'http://makersquare.com/crm/admin'
    mail(to: @user.email, subject: 'Welcome to Pied Piper CRM')
  end

  def email_update
    # if new_contacts?
    #   update(new_contacts)
    # end

    # if pipeline_change?
    #   moved_contacts = database query for moved contacts
    #   update(moved_contacts)
    # end
  end
end
