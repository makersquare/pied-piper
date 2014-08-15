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
    expect(account_signin('new_user@gmail.com')).to be_a(ContextIO::Account)
  end

  it 'can create a new account from Contextio' do
    VCR.use_cassette('Contextio_account_create') do
      account = create_new_account({ email: 'devpiedpiper1@gmail.com', first_name: 'Shehzan', last_name: 'Devani' })
      expect(account).to be_a(ContextIO::Account)
    end
  end

  it 'can create a new source(email account) for a specific account' do
    VCR.use_cassette('Contextio_source_create') do
      inputs = {account: account_signin('devpiedpiper1@gmail.com'), email: 'devpiedpiper1@gmail.com', server: 'imap.gmail.com', username: 'devpiedpiper1@gmail.com', use_ssl: 1, port: 993, type:'IMAP', password: 'workhardplayhard1'}

      create_new_source(inputs)

    end
  end

  xit 'can authenticate a notification' do
  end

  xit 'can convert a json to a hash' do
  end

  xit 'can get a single message' do
  end

  xit 'can retrive multiple messages' do
  end

  xit 'can select the text portions of a message' do
  end

  xit 'can parse a typeform email' do
  end

  xit 'can create a webhook' do
  end
end
