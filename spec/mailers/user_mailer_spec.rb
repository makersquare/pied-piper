require 'spec_helper'

describe UserMailer do
  before(:each) do
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @contact = Contact.create(name: 'Jon', email: 'jonathan.a.katz@gmail.com', phonenumber: '123', city: 'Philadelphia' )
    UserMailer.pipeline_update.deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
