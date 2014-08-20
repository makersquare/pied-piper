class CreatePipeline
  @queue = :pipelines

  def self.perform(name)
    Pipeline.create(name)
  end
end

# class Notification
#   def self.perform(user_id)
#     notifications = Notification.where(user_id: user_id)
#     notifications.destroy
#     Notification.send_email(notifications)
#   end

#   def self.send_email(notifications)
#     create email_body using all of the notifications/events
#     send email to notifications.user
#   end
# end
