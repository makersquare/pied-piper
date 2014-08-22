require 'spec_helper'

describe UpdateContactBox do

  it_behaves_like('TransactionScripts')
  let(:script) {UpdateContactBox.new}

    let (:pipeline) {Pipeline.create(name: "pipeline test")}
    let (:contact) {Contact.create(name: "new contact", email: "a@b.c", phonenumber: "1234567890")}
    let (:field1) {Field.create(pipeline_id: pipeline.id, field_type: "text", field_name: "status")}
    let (:field2) {Field.create(pipeline_id: pipeline.id, field_type: "text", field_name: "cohort")}
    let (:stage1) {Stage.create(name: "first stage", description: "here is a stage", pipeline_id: pipeline.id)}
    let (:stage2) {Stage.create(name: "second stage", description: "another stage", pipeline_id: pipeline.id)}
    let! (:box) {Box.create(contact_id: contact.id, pipeline_id: pipeline.id, stage_id: stage1.id, payment_plan_id: 1)}
    let (:boxfield1) {BoxField.create(field_id: field1.id, box_id: box.id, value: "application accepted")}
    let (:boxfield2) {BoxField.create(field_id: field2.id, box_id: box.id, value: "SF2")}
    let (:note1) {Note.create(user_id: 1, box_id: box.id, notes: "first note")}
    let (:note2) {Note.create(user_id: 2, box_id: box.id, notes: "second note")}

    it "fails if no contact_id is passed" do
        result = UpdateContactBox.run({pipeline_id: pipeline.id})
        expect(result.success?).to eq(false)
        expect(result.error).to eq(:no_contact_id_passed)
    end

    it "fails if no pipeline_id is passed" do
        result = UpdateContactBox.run({contact_id: contact.id})
        expect(result.success?).to eq(false)
        expect(result.error).to eq(:no_pipeline_id_passed)
    end

    it "fails if no box is identified" do
        result = UpdateContactBox.run({contact_id: 1000, pipeline_id: pipeline.id})
        expect(result.success?).to eq(false)
        expect(result.error).to eq(:no_box_found_for_contact_id_and_pipeline_id)
    end

  it "updates a contact's information" do
    result = UpdateContactBox.run({contact_id: contact.id,
        pipeline_id: pipeline.id,
        contact: {city: "SF", phonenumber: "0987654321"}
        })
    retrieved_contact = Contact.find(contact.id)
    expect(result.success?).to eq(true)
    expect(retrieved_contact.city).to eq("SF")
    expect(retrieved_contact.phonenumber).to eq("0987654321")
  end

  it "updates field values" do
    result = UpdateContactBox.run({contact_id: contact.id,
        pipeline_id: pipeline.id,
        field_values: [{id: boxfield1.id, field_id: field1.id, box_id: box.id, value: "pending"}, {id: boxfield2.id, field_id: field2.id, box_id: box.id, value: "update"}]
        })
    expect(result.success?).to eq(true)
    expect(result.field_values.first.value).to eq("pending")
    expect(result.field_values.last.value).to eq("update")
    retrieved_field_value1 = BoxField.find(result.field_values.first.id)
    retrieved_field_value2 = BoxField.find(result.field_values.last.id)
    expect(retrieved_field_value1.value).to eq("pending")
    expect(retrieved_field_value2.value).to eq("update")
  end

  it "updates stage information" do
    result = UpdateContactBox.run({
        contact_id: contact.id,
        pipeline_id: pipeline.id,
        stage_id: stage2.id
        })
    expect(result.success?).to eq(true)
    expect(result.box.stage_id).to eq(stage2.id)
    retrieved_stage = Stage.find(result.box.stage_id)
    retrieved_history = BoxHistory.find_by(stage_id: result.box.stage_id)
    expect(retrieved_stage.id).to eq(stage2.id)
    expect(retrieved_stage.name).to eq(stage2.name)
    expect(retrieved_stage.description).to eq(stage2.description)
    expect(retrieved_stage.pipeline_id).to eq(stage2.pipeline_id)
    expect(retrieved_history.stage_id).to eq(stage2.id)
    expect(retrieved_history.stage_from).to eq(stage1.id)
  end

  it "updates notes" do
    result = UpdateContactBox.run({contact_id: contact.id,
        pipeline_id: pipeline.id,
        notes: [{id: note1.id, notes: "updated note"}, {id: note2.id, notes: "second update"}]})
    expect(result.success?).to eq(true)
    expect(result.notes.first.notes).to eq("updated note")
    expect(result.notes.last.notes).to eq("second update")
    retrieved_note1 = Note.find(result.notes.first.id)
    retrieved_note2 = Note.find(result.notes.last.id)
    expect(retrieved_note1.notes).to eq("updated note")
    expect(retrieved_note2.notes).to eq("second update")
  end
end
