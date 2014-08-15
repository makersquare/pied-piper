require 'spec_helper'

describe RetrieveAllContactInfo do
  it_behaves_like('TransactionScripts')

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

  describe "retrieval of pipeline info" do
    let(:p1) {Pipeline.create(name: "Pipeline1")}
    let(:p2) {Pipeline.create(name: "Pipeline2")}

    before do
      AddContactToPipeline.run(contact_id: c1.id, pipeline_id: p1.id)
      AddContactToPipeline.run(contact_id: c1.id, pipeline_id: p2.id)
      AddContactToPipeline.run(contact_id: c2.id, pipeline_id: p2.id)
    end

    it "retrieves pipeline array of correct size" do
      result = RetrieveAllContactInfo.run({})
      expect(result.contacts[0].pipelines).to be_a(Array)
      expect(result.contacts[0].pipelines.size).to eq(2)
      expect(result.contacts[1].pipelines.size).to eq(1)
      expect(result.contacts[2].pipelines.size).to eq(0)
    end

    it "retrieves pipelines that contact is part of" do
      result = RetrieveAllContactInfo.run({})
      expect(result.contacts[0].pipelines[0]["name"]).to eq(p1.name)
      expect(result.contacts[0].pipelines[0]["id"]).to eq(p1.id)
      expect(result.contacts[0].pipelines[1]["name"]).to eq(p2.name)
      expect(result.contacts[0].pipelines[1]["id"]).to eq(p2.id)

      expect(result.contacts[1].pipelines[0]["name"]).to eq(p2.name)
      expect(result.contacts[1].pipelines[0]["id"]).to eq(p2.id)

    end
  end
end
