class EmailEvent
  attr_accessor :recipients

  @queue = :email_events

  def self.perform(params)
    #TODO


    # event_id = params[:id]
    # event_type = params[:type]

    # case event_type
    # when "NewContact"
    #   event = NewContactEmailEvent.find(event_id)
    # when "StageChange"
    #   event = StageChangeEmailEvent.find(event_id)
    # when "PipelineChange"
    #   event = StageChangeEmailEvent.find(event_id)
    # when "NoteChange"
    #   event = NoteChangeEmailEvent.find(event_id)
    # end

    # EmailEvent.recipients.each do |user|
    #   notification = Notification.create(
    #     event_id: event_id,
    #     event_type: event_type,
    #     user_id: user.id
    #   )
    #   if user.email_setting == "RealTime"
    #     Resque.enqueue(Notification, user.id)
    #   elsif user.email_setting = "4 hours"
    #     Resque.enqueue(Notification, user.id, 4.hours)
    #   end
    # end
  end

  def recipients
    @recipients = User.all
  end
end
