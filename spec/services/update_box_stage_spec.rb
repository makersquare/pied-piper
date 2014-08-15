require 'spec_helper'

describe UpdateBoxStage do
  # Updates a box stage and documents the update in the box_history table

  it_behaves_like('TransactionScripts')
  let(:script) {UpdateBoxStage.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  it "updates the box stage and documents the change in the box_history table" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phonenumber=>'1234567'})
    b1 = CreateBox.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id, :stage_id=>1, :pipeline_location=>2})

    result = UpdateBoxStage.run({:box_id=>b1.box.id, :stage_id=>2})
    box = result.box
    history = result.history

    expect(result.success?).to eq(true)
    expect(box.id).to_not be(nil)
    expect(box.contact_id).to eq(c1.contact.id)
    expect(box.pipeline_id).to eq(p1.data.id)
    expect(box.stage_id).to eq(2)
    expect(history.box_id).to eq(b1.box.id)
    expect(history.stage_id).to eq(2)
    expect(history.stage_from).to eq(1)
  end

end
