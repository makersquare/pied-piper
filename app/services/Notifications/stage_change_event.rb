# Run this script to notify users of a stage change
# that has occurred. This script will add a job
# to the Resque queue which will generate the actual
# notifications.

class StageChangeEvent < TransactionScript

  # Adds this event to the Reque queue
  def run(params)
    if params[:box_history_id].nil?
      return failure(:no_box_history_passed)
    end

    Resque.enqueue(self.class, params)
    success
  end
end
