class NewContactEE < EmailEvent
  def recipients
    @recipients = PipelineUser.all
  end
end
