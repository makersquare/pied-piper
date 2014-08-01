require 'spec_helper'

describe GetPipelineContacts do

  it_behaves_like('TransactionScripts')
  let(:script) {GetPipelineContacts.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  it "gets contacts given pipeline location" do
    c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phoneNum=>'1234567'})
    c2 = CreateContact.run({:name=>'contact2', :email=>'you@email.com', :phoneNum=>'2234567'})
    c3 = CreateContact.run({:name=>'contact3', :email=>'they@email.com', :phoneNum=>'3234567'})

    result = GetPipelineContacts.run(p1.id)
    contacts = result.contact

    expect(result.success?).to eq(true)
    expect(contacts.length).to eq(3)
    expect(contacts.first.name).to eq('contact1')
    expect(contacts.last.phoneNum).to eq('3234567')
  end

end
