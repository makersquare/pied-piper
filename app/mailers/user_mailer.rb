class UserMailer < ActionMailer::Base

# Provide the default sender for emails.
  default from: "MakerSquare CRM Notifications"

# Sends email to admin upon registration.
  def registration_email(user)
    @name = user.name
    @email = user.email
    @url = root_path
    mail(to: @email,
        subject: 'You have successfully registered for the MakerSquare CRM',
        template_path: 'user_mailer',
        template_name: 'registration_email'
        )
  end

# Sends email after a stage change.
  def stage_change_update(contact)
    @url = root_path
    @time = Time.now.strftime("%A, %B %d, %Y")
    @email_users = User.all
    @email_users.each do |email_user|
      mail(to: email_user.user.email,
        subject: 'MakerSquare CRM Notification: Stage Change Update at ' + @time.to_s,
        template_path: 'user_mailer',
        template_name: 'pipeline_update'
        )
    end
  end

  def send_user_update(user, email_body)
    mail(
      to: user.email,
      subject: 'MakerSquare CRM Notification: Updates at ' + Time.now.strftime("%A, %B %d, %Y").to_s,
      body: email_body
    ).deliver
  end

# Sends email when a new contact is created.
  def new_contact_update(contact)
    @name = contact.name
    @city = contact.city
    @phone_number = contact.phonenumber
    @time = Time.now
    @email_users = User.all
    @email_users.each do |email_user|
      mail(to: email_user.email,
        subject: 'MakerSquare CRM Notification: New Contact Added',
        template_path: 'user_mailer',
        template_name: 'new_contact_update'
        )
    end
  end

# Sends email when a user/contact moves from one pipeline to another.
  def pipeline_update
   mail(to: 'jonathan.a.katz@gmail.com',
    subject: 'MakerSquare CRM Notification: Pipeline Update',
    template_path: 'user_mailer',
    template_name: 'pipeline_update'
    )
  end
end
