require 'spec_helper'

describe UpdateContactFieldValues do
  let(:contact) {Contact.create(name: "test", email: "t@t.com",
        city: "testcity", phonenumber: "9721234567")}

  let(:pipeline) {Pipeline.create(name: "test_pipeline")}

  let!(:field) {Field.create(field_name: "Admitted", pipeline_id: 1)}

  let!(:box_field) {BoxField.create(field_id: field.id, value: "Y")}

  it "fails when there is no contact_id" do
    result = UpdateContactFieldValues.run({field_id: 1})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_contact_id_passed_in)
  end

  it "fails when the contact id is invalid" do
    result = UpdateContactFieldValues.run({contact_id: 1000, field_id: field.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_contact_id)
  end

  it "fails when there is no boxfield field_id" do
    result = UpdateContactFieldValues.run({contact_id: 1})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_field_id_passed_in)
  end

  it "fails when the boxfield field_id is invalid" do
    result = UpdateContactFieldValues.run({contact_id: 1, field_id: 10})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_boxfield_field_id)
  end

  it "fails when no boxfield hash is passed" do
    result = UpdateContactFieldValues.run({contact_id: 1, field_id: field.id})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_boxfield_info_passed)
  end

  it "updates the boxfield value given contact_id and field_id" do
    result = UpdateContactFieldValues.run({contact_id: 1, field_id: field.id, box_field: {field_id: field.id, value: "updated"}})
    expect(result.success?).to eq(true)
    expect(result.boxfield.value).to eq("updated")
  end

  it "raises exception when extraneous information is passed in" do
    expect{
      UpdateContactFieldValues.run({
      contact_id: 1,
      field_id: field.id,
      box_field: {
        field_id: field.id,
        value: "updated",
        asdf: "hi"}})}.to raise_error
  end

end
