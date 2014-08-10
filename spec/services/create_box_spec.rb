require 'spec_helper'

describe CreateBox do

  it_behaves_like('TransactionScripts')
  let(:script) {CreateBox.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  it "creates a box with fields" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phonenumber=>'1234567'})

    result = CreateBox.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id, :stage_id=>1, :pipeline_location=>2})
    box = result.box

    expect(result.success?).to eq(true)
    expect(box.id).to_not be(nil)
    expect(box.contact_id).to eq(c1.contact.id)
    expect(box.pipeline_id).to eq(p1.data.id)
    expect(box.stage_id).to eq(1)
    expect(box.pipeline_location).to eq(2)
  end

end
