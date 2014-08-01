# require 'spec_helper'

# describe GetContactsByPipelineId do

#   it_behaves_like('TransactionScripts')
#   let(:script) {GetContactsByPipelineId.new}

#   describe 'Validation' do

#     xit "requires a valid session" do
#     end
#   end

#   it "gets all contacts associated with a pipeline by pipeline id" do
#     p1 = CreatePipelineScript.run({:name=>'pipeline1'})
#     c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phoneNum=>'1234567'})
#     c2 = CreateContact.run({:name=>'contact2', :email=>'you@email.com', :phoneNum=>'2234567'})
#     # pc1 = AddContactToPipeline.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id})
#     # pc2 = AddContactToPipeline.run({:contact_id=>c2.contact.id, :pipeline_id=>p1.data.id})
#     b1 = CreateBox.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id})
#     b2 = CreateBox.run({:contact_id=>c2.contact.id, :pipeline_id=>p1.data.id})

#     result = GetContactsByPipelineId.run({:pipeline_id=>p1.data.id})
#     contacts = result.contacts

#     expect(result.success?).to eq(true)
#     expect(contacts.length).to eq(2)
#     expect(contacts.first.id).to eq(c1.contact.id)
#     expect(contacts.last.id).to eq(c2.contact.id)
#   end

# end
