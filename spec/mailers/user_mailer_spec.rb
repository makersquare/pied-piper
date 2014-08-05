require "spec_helper"

describe UserMailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @contact = Contact.create(name: 'Jon', email: 'jonathan.a.katz@gmail.com', phoneNum: '123', city: 'Philadelphia' )
    UserMailer.pipeline_update(@contact).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end


  it 'should send an email ' do
    ActionMailer::Base.deliveries.count.should == 1
  end

  it 'renders the receiver email' do
    ActionMailer::Base.deliveries.first.to.should == @contact.email
  end

  it 'should set the subject to the correct subject' do
    time = Time.parse("Aug 5 2014")
    Time.stub!(:now).and_return(time)

    ActionMailer::Base.deliveries.first.subject.should == 'Pipeline Update for #{time}'
  end
end

  # create_table "users", force: true do |t|
  #   t.string   "name"
  #   t.string   "email"
  #   t.boolean  "admin"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"


  # create_table "contacts", force: true do |t|
  #   t.string "name"
  #   t.string "email"
  #   t.string "phoneNum"
  #   t.string "city"
