class StageChangeEvent < ActiveRecord::Base
  has_many :notifications, as: :event
  after_create :create_notifications


  def create_notifications
    recipients.each do |user|
      notification = self.notifications.build(
        user: user
      )
      notification.save
    end
  end

  def recipients
    User.all
  end

  def email_body
    "Hello World #{id}"
  end
end


# StageChangeEvent.create(box_history_id: bh)
