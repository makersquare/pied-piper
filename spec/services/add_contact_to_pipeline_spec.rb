require 'spec_helper'

describe AddContactToPipeline do

  it_behaves_like('TransactionScripts')
  let(:script) {AddContactToPipeline.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  it "creates a contact" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phoneNum=>'1234567'})
    c2 = CreateContact.run({:name=>'contact2', :email=>'you@email.com', :phoneNum=>'2234567'})

    result = AddContactToPipeline.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id})

    contact = result.contact

    expect(result.success?).to eq(true)
    expect(contact.contact_id).to eq(contact.contact_id)
    expect(contact.pipeline_id).to eq(contact.pipeline_id)
  end

end
