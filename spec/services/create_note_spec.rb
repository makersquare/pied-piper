require 'spec_helper'

describe CreateNote do

  it_behaves_like('TransactionScripts')
  let(:script) {CreateNote.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  it "creates a note within a box" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phonenumber=>'1234567'})
    b1 = CreateBox.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id, :stage_id=>1, :pipeline_location=>2})

    result = CreateNote.run({:user_id=>1, :box_id=>b1.box.id, :notes=>'called for info', :pipeline_id=>p1.data.id, :contact_id=>c1.contact.id})
    note = result.box.notes.first

    expect(result.success?).to eq(true)
    expect(note.id).to_not be(nil)
    expect(note.user_id).to eq(1)
    expect(note.box_id).to eq(b1.box.id)
    expect(note.notes).to eq('called for info')
  end

end
