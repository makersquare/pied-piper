require 'spec_helper'

describe CreateContact do

  it_behaves_like('TransactionScripts')
  let(:script) {CreateContact.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  it "creates a contact" do
    result = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phonenumber=>'1234567'})
    contact = result.contact
    expect(result.success?).to eq(true)
    expect(contact.name).to eq('contact1')
    expect(contact.email).to eq('me@email.com')
    expect(contact.phonenumber).to eq('1234567')
  end

   it "creates a contact" do
    result = CreateContact.run({ :email=>'me@email.com', :phoneNum=>'1234567'})
    expect(result.success?).to be_false
    expect(result.error).to eq('Contact is missing name')
  end

end
