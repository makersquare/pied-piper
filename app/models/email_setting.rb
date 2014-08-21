#  TODO: Can this be deleted?
class EmailSetting < ActiveRecord::Base
  belongs_to :pipeline_user

  def user
    pipeline_user.user
  end

  def pipeline
    pipeline_user.pipeline
  end
end
