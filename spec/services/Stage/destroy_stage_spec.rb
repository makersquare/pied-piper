require "spec_helper"

describe DestroyStage do

  let(:contact) {Contact.create(name: "contact name", email: "a@b.c", phonenumber: "124567890", city: "here")}
  let(:contact2) {Contact.create(name: "contact2 name", email: "a2@b.c", phonenumber: "124567890", city: "elsewhere")}
  let!(:box) {Box.create(contact_id: contact.id, stage_id: stage2.id, pipeline_id: pipeline.id)}
  let!(:box2) {Box.create(contact_id: contact2.id, stage_id: stage2.id, pipeline_id: pipeline.id)}
  let(:pipeline) {Pipeline.create(name: "pipeline name")}
  let(:pipeline2) {Pipeline.create(name: "pipeline2 name")}
  let!(:stage) {Stage.create(name: "default", description: "a stage", pipeline_id: pipeline.id, pipeline_location: 1, standard_payment_plan_id: 1, payment: true)}
  let!(:stage2) {Stage.create(name: "destroy me", description: "another stage", pipeline_id: pipeline.id, pipeline_location: 2, standard_payment_plan_id: 1, payment: true)}
  let(:stage3) {Stage.create(name: "stage without default", description: "a stage", pipeline_id: pipeline2.id, pipeline_location: 2, standard_payment_plan_id: 1, payment: true)}

  it "fails if the stage_id is nil" do
    result = DestroyStage.run({})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_stage_id_passed)
  end

  it "fails if the stage_id is invalid" do
    result = DestroyStage.run({id: 10000})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_stage_id)
  end

  it "fails if the stage_id is the default stage_id" do
    result = DestroyStage.run({id: stage.id})
    expect(result.error).to eq(:cannot_destroy_default_stage)
  end

  it "fails if no default stage is defined" do
    result = DestroyStage.run({id: stage3.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_default_stage_defined)
  end

  it "finds all contacts associated with a stage and moves them to the default stage for that pipeline" do
    result = DestroyStage.run({id: stage2.id})
    expect(result.success?).to eq(true)
    retrieve_contact_boxes = Box.where({stage_id: stage.id})
    expect(retrieve_contact_boxes.first.stage_id).to eq(stage.id)
    expect(retrieve_contact_boxes.first.pipeline_location).to eq(stage.pipeline_location)
    expect(retrieve_contact_boxes.last.stage_id).to eq(stage.id)
    expect(retrieve_contact_boxes.last.pipeline_location).to eq(stage.pipeline_location)
  end

  it "destroys the stage" do
    result = DestroyStage.run({id: stage2.id})
    expect(result.success?).to eq(true)
    retrieve_stage = Stage.where(id: stage2.id).first
    expect(retrieve_stage).to be_nil
  end
end
