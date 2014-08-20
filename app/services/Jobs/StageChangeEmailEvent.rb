class StageChangeEE < EmailEvent
  def recipients
    @recipients = PipelineUser.all
  end
end
