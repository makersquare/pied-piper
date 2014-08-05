class UserMailer < ActionMailer::Base
  # def welcome_email(user)
  #   @user = user
  #   @url = 'http://makersquare.com/crm/admin'
  #   mail(to: @user.email, subject: 'Welcome to Pied Piper CRM')
  # end

  def pipeline_update
    mail(to: 'gabe.a.polk@gmail.com', subject: 'This is a test')
  end

  # def pipeline_update
  #   @user = User.all
  #   @user.each do |user|
  #     mail(to: user.email,
  #          subject: 'Pipeline Update',
  #          template_path: '',
  #          template_name: 'another')
  #   end
  # end
end

# UserMailer.pipelineUpdate.deliver
