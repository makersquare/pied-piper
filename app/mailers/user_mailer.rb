class UserMailer < ActionMailer::Base
  default from: "MakerSquare CRM Notifications"

  # def welcome_email(user)
  #   @user = user
  #   @url = 'http://makersquare.com/crm/admin'
  #   mail(to: @user.email, subject: 'Welcome to Pied Piper CRM')
  # end

# UserMailer.pipelineUpdate.deliver

# might want to use @email_users = EmailSettings.where(setting: "RealTime") at some point
  def stage_change_update(contact)
    @url = 'http://makersquare.com/crm/admin'
    @time = Time.now.strftime("%A, %B %d, %Y")
    # @email_users = EmailSettings.all
    @email_users = users
    @email_users.each do |email_user|
      mail(to: email_user.user.email,
        subject: 'MakerSquare CRM Notification: Stage Change Update at ' + @time.to_s,
        template_path: 'user_mailer',
        template_name: 'pipeline_update'
        )
    end
  end

  def new_contact_update(contact)
    @name = contact.name
    @city = contact.city
    @phone_number = contact.phoneNum
    @time = Time.now

    @email_users.each do |email_user|
      mail(to: email_user.user.email,
        subject: 'MakerSquare CRM Notification: New Contact Added',
        template_path: 'user_mailer',
        template_name: 'pipeline_update'
        )
    end
  end
end

# To test methods...use this mail to
  # mail(to: 'jonathan.a.katz@gmail.com',
  #   subject: 'Pipeline update for ' + @time.to_s,
  #   template_path: 'user_mailer',
  #   template_name: 'pipeline_update'
  #   )


##########   Table References   ###########
  # create_table "email_settings", force: true do |t|
  #   t.integer  "user_id"
  #   t.string   "setting"
  #   t.integer  "pipeline_id"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

  # create_table "box_histories", force: true do |t|
  #   t.integer  "box_id"
  #   t.integer  "stage_id"
  #   t.integer  "stage_from"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

  #   create_table "pipeline_users", force: true do |t|
  #   t.integer  "user_id"
  #   t.integer  "pipeline_id"
  #   t.boolean  "admin"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

  #   create_table "stages", force: true do |t|
  #   t.string   "name"
  #   t.text     "description"
  #   t.integer  "pipeline_id"
  #   t.integer  "pipeline_location"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

  # create_table "contacts", force: true do |t|
  #   t.string "name"
  #   t.string "email"
  #   t.string "phoneNum"
  #   t.string "city"
  # end
