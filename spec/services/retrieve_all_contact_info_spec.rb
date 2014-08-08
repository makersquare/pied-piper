require 'spec_helper'

describe RetrieveAllContactInfo do
  it_behaves_like('TransactionScripts')

  context "no pipeline ID given" do
    let!(:c1) {Contact.create(name: "Jack1", email: "j1@j.com", city: "sf", phonenumber: "1231")}
    let!(:c2) {Contact.create(name: "Jack2", email: "j2@j.com", city: "atx", phonenumber: "1232")}
    let!(:c3) {Contact.create(name: "Jack3", email: "j3@j.com", city: "atl", phonenumber: "1233")}

    it "retrieves all contacts and associated data" do
      result = RetrieveAllContactInfo.run({})
      expect(result.success?).to eq(true)
      expect(result.contacts.size).to eq(3)
      expect(result.contacts[0].name).to eq(c1.name)
      expect(result.contacts[1].name).to eq(c2.name)
      expect(result.contacts[2].name).to eq(c3.name)
    end
  end

  context "a pipeline ID is given" do

    it "errors out with an invalid pipeline id" do
      result = RetrieveAllContactInfo.run({pipeline_id: -1})
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:invalid_pipeline_id)
    end

    context "proper pipeline id given" do
      let(:pipeline) { Pipeline.create(name: "My Pipeline") }
      let(:params) { {pipeline_id: pipeline.id} }

      it "returns an empty array if there are no contacts" do
        result = RetrieveAllContactInfo.run(params)
        expect(result.success?).to eq(true)
        expect(result.contacts).to eq([])
      end

      context "pipeline has contacts" do
        let(:c1) {Contact.create(name: "Jack1", email: "j1@j.com", city: "sf", phonenumber: "1231")}
        let(:c2) {Contact.create(name: "Jack2", email: "j2@j.com", city: "atx", phonenumber: "1232")}
        let(:c3) {Contact.create(name: "Jack3", email: "j3@j.com", city: "atl", phonenumber: "1233")}
        let(:field1) {Field.create(pipeline_id: pipeline.id, field_name: "Field 1", field_type: "String")}
        let(:field2) {Field.create(pipeline_id: pipeline.id, field_name: "Field 2", field_type: "String")}
        let(:stage1) {Stage.create(name: "First Stage", pipeline_id: pipeline.id)}
        let(:stage2) {Stage.create(name: "Second Stage", pipeline_id: pipeline.id)}
        let!(:box1) {Box.create(contact_id: c1.id, pipeline_id: pipeline.id, stage_id: stage1.id)}
        let!(:box2) {Box.create(contact_id: c3.id, pipeline_id: pipeline.id, stage_id: stage2.id)}
        let!(:box1_field1) {BoxField.create(field_id: field1.id, box_id: box1.id, value: "Contact 1 Field 1")}
        let!(:box1_field2) {BoxField.create(field_id: field2.id, box_id: box1.id, value: "Contact 1 Field 2")}
        let!(:box2_field1) {BoxField.create(field_id: field1.id, box_id: box2.id, value: "Contact 2 Field 1")}
        let!(:box2_field2) {BoxField.create(field_id: field2.id, box_id: box2.id, value: "Contact 2 Field 2")}

        it "has 2 contacts in the response" do
          result = RetrieveAllContactInfo.run(params)
          expect(result.success?).to eq(true)
          expect(result.contacts.size).to eq(2)
        end

        it "includes the proper contact's info" do
          result = RetrieveAllContactInfo.run(params)
          basic_keys = [:name, :email, :id]
          expect(result.contacts[0][:id]).to eq(c1.id)
          expect(result.contacts[0].name).to eq(c1.name)
          expect(result.contacts[0].email).to eq(c1.email)

          expect(result.contacts[1].id).to eq(c3.id)
          expect(result.contacts[1].name).to eq(c3.name)
          expect(result.contacts[1].email).to eq(c3.email)
        end

        it "includes the contact's stage id" do
          result = RetrieveAllContactInfo.run(params)
          expect(result.contacts[0].stage_id).to eq(stage1.id)
          expect(result.contacts[1].stage_id).to eq(stage2.id)
        end

        it "includes the contact's box fields" do
          result = RetrieveAllContactInfo.run(params)
          expect(result.contacts[0]["Field 1"]).to eq("Contact 1 Field 1")
          expect(result.contacts[0]["Field 2"]).to eq("Contact 1 Field 2")
          expect(result.contacts[1]["Field 1"]).to eq("Contact 2 Field 1")
          expect(result.contacts[1]["Field 2"]).to eq("Contact 2 Field 2")
        end
      end
    end
  end
end
