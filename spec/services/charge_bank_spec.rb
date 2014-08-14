require 'spec_helper'

describe ChargeBank do
  it_behaves_like('TransactionScripts')

  it 'fails if bank account is not correct' do
    test = described_class.run({"uri"=>"/bank_accounts/doesnotexist", "email"=>"alex@gmail.com", "type"=>"bank"})
    expect(test.error).to eq('incorrect bank account info')
  end

  it 'fails if contact is not in db' do
    test = described_class.run({"uri"=>"/bank_accounts/BA6MSI0w6MPGjDb4KPrgDPgn", "email"=>"doesnotexist@gmail.com", "type"=>"bank"})
    expect(test.error).to eq('why are you trying to give us money? you havent applied')
  end

  it 'it returns tranactino attributes if succeful' do
    test = described_class.run({"uri"=>"/bank_accounts/BA6MSI0w6MPGjDb4KPrgDPgn", "email"=>"alex@gmail.com", "type"=>"bank"})
    expect(test.success?).to be_true
  end
end
