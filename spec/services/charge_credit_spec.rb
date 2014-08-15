require 'spec_helper'

describe ChargeCredit do
  it_behaves_like('TransactionScripts')

  it 'fails if contact is not in db' do
    VCR.use_cassette('test_no_contact_for_credit') do
      test = described_class.run({"uri"=>"/cards/CCZrwTpmU3G1lxtoL43EN4m", "email"=>"doesnotexist@gmail.com", "type"=>"bank"})
      expect(test.error).to eq('why are you trying to give us money? you havent applied')
    end
  end

  it 'it returns transaction attributes if successfull' do
    VCR.use_cassette('test_succesful_balanced_credit') do
      addContact = CreateContact.run({:name=>'alex haines', :email=>'alex@gmail.com', :phonenumber=>'1234567'})
      test = described_class.run({"uri"=>"/cards/CCZrwTpmU3G1lxtoL43EN4m", "email"=>"alex@gmail.com", "type"=>"bank"})
      expect(test.success?).to be_true
    end
  end
end
