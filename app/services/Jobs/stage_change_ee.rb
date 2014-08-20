class StageChangeEE
  @queue = :email_events

  def self.perform(stage_change)
    @recipients.each do |user|
      notification = Notification.create(
        )
    end
  end

  def recipients
    @recipients = User.all
  end

  def email_body
    "Hello"
  end
end
