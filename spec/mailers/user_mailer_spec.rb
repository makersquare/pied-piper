require 'spec_helper'

describe UserMailer do
  before(:each) do
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @user = CreateUser.run({:name=> "user1", :email=> "user@user.com", :provider=>'provider'})
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it "sends an email when a new user is created" do
    expect(ActionMailer::Base.deliveries.size).to eq(1)
  end

  it "sends an email when a new contact is created" do
    contact = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phonenumber=>'1234567'})
    expect(ActionMailer::Base.deliveries.size).to eq(2)
    expect(ActionMailer::Base.deliveries[1].subject).to eq('MakerSquare CRM Notification: New Contact Added')

    new_contact = CreateContact.run({:name=>'contact2', :email=>'you@email.com', :phonenumber=>'2234567'})
    expect(ActionMailer::Base.deliveries.size).to eq(3)
  end
end
