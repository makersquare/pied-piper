# require 'spec_helper'

# describe GetPipelineContacts do

#   it_behaves_like('TransactionScripts')
#   let(:script) {GetPipelineContacts.new}

#   describe 'Validation' do

#     xit "requires a valid session" do
#     end
#   end

#   it "gets contacts given pipeline location" do
#     p1 = CreatePipeline.run({:name=>'pipeline1'})
#     s1 = CreateStage.run({:pipeline_id=>p1.id, :name=>'stage1'}, :description=>'first stage', :pipeline_location=>1)
#     s2 = CreateStage.run({:pipeline_id=>p1.id, :name=>'stage2'}, :description=>'second stage', :pipeline_location=>2)

#     c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phonenumber=>'1234567'})
#     c2 = CreateContact.run({:name=>'contact2', :email=>'you@email.com', :phonenumber=>'2234567'})
#     c3 = CreateContact.run({:name=>'contact3', :email=>'they@email.com', :phonenumber=>'3234567'})

#     b1 = CreateBox.run({:contact_id=>c1.id, :pipeline_id=>p1.id, :stage_id=>s1.id})
#     b2 = CreateBox.run({:contact_id=>c2.id, :pipeline_id=>p1.id, :stage_id=>s2.id})

#     result = GetPipelineContacts.run(p1.id)
#     contacts = result.contact

#     expect(result.success?).to eq(true)
#     expect(contacts.length).to eq(2)
#     expect(contacts.first.name).to eq('contact1')
#     expect(contacts.first.stage).to eq(1)
#   end

# end
