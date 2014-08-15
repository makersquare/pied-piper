require 'spec_helper'

describe ChargeBank do
  it_behaves_like('TransactionScripts')

  it 'fails if contact is not in db' do
    VCR.use_cassette('test_no_contact') do
      test = described_class.run({"uri"=>"/bank_accounts/BA6MSI0w6MPGjDb4KPrgDPgn", "email"=>"doesnotexist@gmail.com", "type"=>"bank"})
      expect(test.error).to eq('why are you trying to give us money? you havent applied')
    end
  end

  it 'it returns transaction attributes if successfull' do
    VCR.use_cassette('test_succesful_balanced') do
      addContact = CreateContact.run({:name=>'alex haines', :email=>'alex@gmail.com', :phonenumber=>'1234567'})
      test = described_class.run({"uri"=>"/bank_accounts/BA6MSI0w6MPGjDb4KPrgDPgn", "email"=>"alex@gmail.com", "type"=>"bank"})
      expect(test.success?).to be_true
    end
  end
end
