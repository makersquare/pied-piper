require 'spec_helper'

describe UpdateContactFieldValues do

  let(:pipeline) {Pipeline.create(name: "test_pipeline")}

  let!(:field) {Field.create(field_name: "Admitted", pipeline_id: 1)}

  let!(:box_field) {BoxField.create(field_id: field.id, value: "Y")}

  it "fails when the boxfield id is invalid" do
    result = UpdateContactFieldValues.run({contact_id: 1, field_values: {id: 1000}})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_field_value_id)
  end

  it "fails when no field_values hash is passed" do
    result = UpdateContactFieldValues.run({contact_id: 1, field_id: field.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_field_value_info_passed)
  end

  it "updates the boxfield value given a field_values hash" do
    result = UpdateContactFieldValues.run({contact_id: 1, field_id: field.id, field_values: {id: box_field.id, value: "updated"}})
    retrieved_field_values = BoxField.find(result.boxfield.id)
    expect(result.success?).to eq(true)
    expect(retrieved_field_values.value).to eq("updated")
  end

  it "raises exception when extraneous information is passed in" do
    expect{
      UpdateContactFieldValues.run({
      contact_id: 1,
      field_values: {
        id: box_field.id,
        value: "updated",
        asdf: "hi"}})}.to raise_error
  end

end
