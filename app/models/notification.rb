class Notification < ActiveRecord::Base
  @queue = :notifications
  belongs_to :user
  belongs_to :event, polymorphic: true
  after_create :add_to_resque

  def add_to_resque
    Resque.enqueue_in(60.seconds, Notification, self.user.id)
  end

  def self.perform(user_id)
    notifications = User.find(user_id).notifications
    texts = notifications.map {|n| n.event.email_body}
    email = texts.join("\n\n\n")
    Rails.logger.info(email)
    puts email
  end
end
