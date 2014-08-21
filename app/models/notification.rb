$time_to_send = 10.seconds
class Notification < ActiveRecord::Base
  @queue = :notifications
  belongs_to :user
  belongs_to :event, polymorphic: true
  after_create :add_to_resque

  def add_to_resque
    # Hard coding to 4 hours. Need to change this based on
    # email settings which is broken
    Resque.enqueue_in($time_to_send, Notification, self.user.id)
  end

  def self.perform(user_id)
    # notifications = User.find(user_id).notifications
    # texts = notifications.map {|n| n.event.email_body}
    # email = texts.join("\n\n\n")
    # Rails.logger.info(email)
    # puts email
    user = User.find(user_id)
    if (Time.now - user.last_email > $time_to_send)
      Notification.send_email(user)
    end
  end

  def self.send_email(user)
    notifications = user.notifications
    events = notifications.map {|n| n.event}
    email_text = events.map {|e| e.email_body}.join("\n\n")
    user.notifications.each {|n| n.destroy}

    UserMailer.send_user_update(user, email_text)

    user.last_email = Time.now
    user.save
  end
end
