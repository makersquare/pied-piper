class NewContactEE < EmailEvent
  def recipients
    @recipients = PipelineUser.all
  end

  def email_body
  end
end
