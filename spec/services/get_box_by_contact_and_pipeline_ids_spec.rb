require 'spec_helper'

describe GetBoxByContactAndPipelineIds do

  it_behaves_like('TransactionScripts')
  let(:script) {GetBoxByContactAndPipelineIds.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  it "gets all contacts associated with a pipeline by pipeline id" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phoneNum=>'1234567'})
    b1 = CreateBox.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id, :stage_id=>1, :pipeline_location=>2})

    result = GetBoxByContactAndPipelineIds.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id})
    box = result.box

    expect(result.success?).to eq(true)
    expect(box.id).to_not be(nil)
    expect(box.contact_id).to eq(c1.contact.id)
    expect(box.pipeline_id).to eq(p1.data.id)
    expect(box.stage_id).to eq(1)
    expect(box.pipeline_location).to eq(2)
  end

end
