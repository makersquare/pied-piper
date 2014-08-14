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
    expect(contextio_signin).to be_a(ContextIO)
  end

  it 'can signin to an account locally' do
    VCR.use_cassette('Contextio_account_email_signin') do
      account = account_email_signin('devpiedpiper@gmail.com')
      expect(account).to be_a(ContextIO::Account)
    end
  end

  it 'can create a new account from Contextio' do
    VCR.use_cassette('Contextio_account_create') do
      account = create_new_account({ email: 'devpiedpiper1@gmail.com', first_name: 'Shehzan', last_name: 'Devani' })
      expect(account).to be_a(ContextIO::Account)
    end
  end

  it 'can create a new source(email account) for a specific account' do
    VCR.use_cassette('Contextio_source_create') do
      inputs = {account: account_email_signin('devpiedpiper1@gmail.com'), email: 'devpiedpiper1@gmail.com', server: 'imap.gmail.com', username: 'devpiedpiper1@gmail.com', use_ssl: 1, port: 993, type:'IMAP', password: 'workhardplayhard1'}
      create_new_source(inputs)
    end
  end

  xit 'can authenticate a notification' do
  end

  xit 'can convert a json to a hash' do
  end

  it 'can get a single message' do
    VCR.use_cassette('get_message') do
      inputs = { account: account_signin('53dab6dffacadd465d52805a'),
        message_id: "53ecc934b0eeaca6688b4567" }
      expect(get_message(inputs)).to be_a(ContextIO::Message)
    end
  end

  it 'can retrive multiple messages' do
    VCR.use_cassette('get_messages') do
      inputs = { account: account_signin('53dab6dffacadd465d52805a'),
          contact_email: "mathias.armstrong@gmail.com", time: 4.weeks.ago.to_i }
      expect(get_messages(inputs)).to be_a(ContextIO::MessageCollection)
    end
  end


  xit 'can select the text portions of a message' do
  end

  xit 'can parse a typeform email' do
  end

  xit 'can create a webhook' do
  end
end
