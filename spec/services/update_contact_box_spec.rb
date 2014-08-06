require 'spec_helper'

describe UpdateContactBox do

  it_behaves_like('TransactionScripts')
  let(:script) {UpdateContactBox.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  it "updates the box associated with a contact in a given pipeline" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    c1 = CreateContact.run({:name=>'contact1', :email=>'me@email.com', :phoneNum=>'1234567'})
    b1 = CreateBox.run({:contact_id=>c1.contact.id, :pipeline_id=>p1.data.id})
    f1 = Field.create({:pipeline_id=>p1.data.id, :field_type=>'text', :field_name=>'status'})
    f2 = Field.create({:pipeline_id=>p1.data.id, :field_type=>'text', :field_name=>'cohort'})
    bf1 = BoxField.create({:field_id=>f1.id, :box_id=>b1.box.id, :value=>'application complete'})
    bf2 = BoxField.create({:field_id=>f2.id, :box_id=>b1.box.id, :value=>'SF2'})
    n1 = Note.create({:user_id=>1, :box_id=>b1.box.id, :notes=>'here you go'})
    n2 = Note.create({:user_id=>1, :box_id=>b1.box.id, :notes=>'second note'})

    result = UpdateContactBox.run({:id=>b1.box.id,
        :pipeline_id=>p1.data.id,
        :contact_id=>c1.contact.id,
        :name=>'updated name',
        :field_id=>f1.id,
        :box_field=>[{:id=>bf1.id, :value=>'interview scheduled'}],
        :notes=>[{:id=>n1.id, :notes=>'updated notes'}, {:id=>n2.id, :notes=>'second updated note'}]})
    box = result.box
    field = result.fields
    box_field = result.field_values
    contact = result.contact
    notes = result.notes

    expect(result.success?).to eq(true)
    expect(box.id).to eq(b1.box.id)
    expect(box.pipeline_id).to eq(p1.data.id)
    expect(box.contact_id).to eq(c1.contact.id)
    expect(contact.name).to eq('updated name')
    expect(contact.email).to eq(c1.contact.email)
    expect(contact.phoneNum).to eq(c1.contact.phoneNum)
    expect(field.first.id).to eq(f1.id)
    expect(field.first.field_name).to eq(f1.field_name)
    expect(field.first.field_type).to eq(f1.field_type)
    expect(field.last.id).to eq(f2.id)
    expect(field.last.field_name).to eq(f2.field_name)
    expect(field.last.field_type).to eq(f2.field_type)
    expect(box_field.first.id).to eq(bf1.id)
    expect(box_field.first.value).to eq('interview scheduled')
    expect(box_field.last.id).to eq(bf2.id)
    expect(box_field.last.value).to eq(bf2.value)
    expect(notes.first.notes).to eq('updated notes')
    expect(notes.last.notes).to eq('second updated note')
  end

end
