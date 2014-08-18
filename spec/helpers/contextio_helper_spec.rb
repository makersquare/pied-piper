require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ContextioHelper. For example:
#
# describe ContextioHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ContextioHelper do
  it 'can signin to Contextio locally' do
    expect(ContextioHelper.contextio_signin).to be_a(ContextIO)
  end

  it 'can signin to an account' do
    VCR.use_cassette('Contextio_account_signin') do
      expect(ContextioHelper.account_email_signin('devpiedpiper1@gmail.com')).to be_a(ContextIO::Account)
    end
  end

  it 'can create a new account from Contextio' do
    VCR.use_cassette('Contextio_account_create') do
      account = ContextioHelper.create_new_account({ email: 'devpiedpiper1@gmail.com', first_name: 'Shehzan', last_name: 'Devani' })
      expect(account).to be_a(ContextIO::Account)
    end
  end

  it 'can create a new source(email account) for a specific account' do
    VCR.use_cassette('Contextio_source_create') do
      inputs = {account: ContextioHelper.account_email_signin('devpiedpiper1@gmail.com'), email: 'devpiedpiper1@gmail.com', server: 'imap.gmail.com', username: 'devpiedpiper1@gmail.com', use_ssl: 1, port: 993, type:'IMAP', options:{password: 'workhardplayhard1'}}

      source = ContextioHelper.create_new_source(inputs)
      expect(source).to be_a(ContextIO::Source)
    end
  end


  it 'can get a single message' do
    VCR.use_cassette('retrieve_a_messages') do
      inputs = { account: ContextioHelper.account_email_signin('devpiedpiper@gmail.com'), message_id: "53ee4070be63fc9c728b4567"}
      message = ContextioHelper.get_message(inputs)
      expect(message).to be_a(ContextIO::Message)
    end
  end

  it 'can retrive multiple messages' do
     VCR.use_cassette('retrieve_multiple_messages') do
      inputs = { account: ContextioHelper.account_email_signin('devpiedpiper@gmail.com'), contact:OpenStruct.new(email:'jered.mccullough@gmail.com'), time: 4.weeks.ago.to_i}
      messages = ContextioHelper.get_messages(inputs)
      expect(messages).to be_a(ContextIO::MessageCollection)
    end
  end

  it 'can select the text portions of a message' do
    VCR.use_cassette('retrieve_a_messages') do
      inputs = { account: ContextioHelper.account_email_signin('devpiedpiper@gmail.com'), message_id: "53ee4070be63fc9c728b4567"}
      message = ContextioHelper.get_message(inputs)
      text = ContextioHelper.select_message_text(message)
      expect(text).to be_a(Hash)
    end
  end

  it 'can create a webhook' do
    VCR.use_cassette('create_a_webhook') do
      user = User.create(name:'dev', email: 'devpiedpiper@gmail.com')
      inputs = { user:user, options:{ sync_period:'immediate' }}
      results = ContextioHelper.create_webhook(inputs)
      expect(results[:webhook]).to be_a(ContextIO::Webhook)
    end
  end

  xit 'can authenticate a notification' do
  end

  xit 'can convert a json to a hash' do
  end

  xit 'can parse a typeform email' do
  end

end
