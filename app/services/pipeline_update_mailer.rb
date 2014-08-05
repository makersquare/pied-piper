# Sends an update email to all users that provides an overview of recent changes to pipeline stages.

# class PipelineUpdateMailer < TransactionScript
#   def run
#     @time = Time.now.strftime("%A, %B %d, %Y")
#     # TODO: Add correct URL
#     @url = 'http://makersquare.com/crm/admin'
#     @users = User.all
#     @users.each do
#       UserMailer.pipeline_update
#     end
#   end
# end
