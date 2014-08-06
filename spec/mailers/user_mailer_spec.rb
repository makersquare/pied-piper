require 'spec_helper'

describe UserMailer do
  before(:each) do
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @contact = Contact.create(name: 'Jon', email: 'jonathan.a.katz@gmail.com', phoneNum: '123', city: 'Philadelphia' )
    UserMailer.pipeline_update.deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it 'sends an email ' do
    # binding.pry
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq("MakerSquare CRM Notifications")
  end

  it 'sets the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq('MakerSquare CRM Notification: Pipeline Update')
  end
end
