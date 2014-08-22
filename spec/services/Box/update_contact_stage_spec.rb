require 'spec_helper'

describe UpdateContactStage do
  let(:contact) {Contact.create(name: "contact name", email: "a@b.c", phonenumber: "124567890", city: "here")}
  let(:contact2) {Contact.create(name: "contact2 name", email: "a2@b.c", phonenumber: "124567890", city: "elsewhere")}
  let(:pipeline) {Pipeline.create(name: "pipeline name")}
  let(:stage) {Stage.create(name: "stage name", description: "a stage", pipeline_id: pipeline.id, pipeline_location: 1, standard_payment_plan_id: 1, payment: true)}
  let(:stage2) {Stage.create(name: "stage2 name", description: "another stage", pipeline_id: pipeline.id, pipeline_location: 1, standard_payment_plan_id: 1, payment: true)}
  let!(:box) {Box.create(contact_id: contact.id, stage_id: stage.id, pipeline_id: pipeline.id)}

  it "fails when there is no contact_id" do
    result = UpdateContactStage.run({pipeline_id: pipeline.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_contact_id_passed)
  end

  it "fails when the contact_id is invalid" do
    result = UpdateContactStage.run({contact_id: 1000, pipeline_id: pipeline.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_contact_id)
  end

  it "fails when there is no pipeline_id" do
    result = UpdateContactStage.run({contact_id: contact.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_pipeline_id_passed)
  end

  it "fails when the pipeline_id is invalid" do
    result = UpdateContactStage.run({contact_id: contact.id, pipeline_id: 1000})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_pipeline_id)
  end

  it "fails when the box id is invalid" do
    result = UpdateContactStage.run({contact_id: contact2.id, pipeline_id: pipeline.id, stage_id: stage.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:box_not_found_with_contact_id_and_pipeline_id)
  end

  it "fails when no stage info is passed" do
    result = UpdateContactStage.run({contact_id: contact.id, pipeline_id: pipeline.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_stage_info_passed)
  end

  it "updates the contact box stage_id given a contact_id and pipeline_id" do
    result = UpdateContactStage.run({contact_id: contact.id, pipeline_id: pipeline.id, stage_id: stage2.id})
    retrieved_box_stage = Box.find(result.box.id)
    expect(result.success?).to eq(true)
    expect(retrieved_box_stage.stage_id).to eq(stage2.id)

  end

  it "updates the box_history with the former and current stage" do
    result = UpdateContactStage.run({contact_id: contact.id, pipeline_id: pipeline.id, stage_id: stage2.id})
    retrieved_box_history = BoxHistory.find(result.history.id)
    expect(result.success?).to eq(true)
    expect(retrieved_box_history.box_id).to eq(box.id)
    expect(retrieved_box_history.stage_from).to eq(stage.id)
    expect(retrieved_box_history.stage_id).to eq(stage2.id)
  end

  it "does not update the box_history if the stage hasn't changed" do
    result = UpdateContactStage.run({contact_id: contact.id, pipeline_id: pipeline.id, stage_id: stage.id})
    expect(result.success?).to eq(true)
    expect(result.history).to eq(:no_stage_change)
  end
end
