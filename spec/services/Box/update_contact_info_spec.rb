require 'spec_helper'

describe UpdateContactInfo do
  let(:contact) {Contact.create(name: "test", email: "t@t.com",
        city: "testcity", phonenumber: "9721234567")}


  it "fails when there is no contact_id" do
    result = UpdateContactInfo.run({})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_contact_id_passed_in)
  end

  it "fails when the contact id is invalid" do
    result = UpdateContactInfo.run({contact_id: 10})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_contact_id)
  end

  it "updates the contact's name when other fields are passed in" do
    result = UpdateContactInfo.run({
      contact_id: contact.id,
      contact: {
        name: "Bob"
      }
    })

    expect(result.success?).to eq(true)
    retrieved_contact = Contact.find(result.contact.id)
    expect(retrieved_contact.id).to eq(contact.id)
    expect(retrieved_contact.name).to eq("Bob")
  end

  it "updates the contact's other fields" do
    result = UpdateContactInfo.run({
      contact_id: contact.id,
      contact: {
        email: "a@b.com",
        phonenumber: "1234",
        city: "Not here"
      }
    })

    expect(result.success?).to eq(true)
    retrieved_contact = Contact.find(result.contact.id)
    expect(retrieved_contact.id).to eq(contact.id)
    expect(retrieved_contact.email).to eq("a@b.com")
    expect(retrieved_contact.phonenumber).to eq("1234")
    expect(retrieved_contact.city).to eq("Not here")
  end

  it "raises exception when there is extraneous data passed in" do
    expect {
      UpdateContactInfo.run({
        contact_id: contact.id,
        contact: {
          name: "Bob",
          alpha: "beta"}
        })
    }.to raise_error
  end

  it "fails when no contact is passed" do
    result = UpdateContactInfo.run({
      contact_id: contact.id
    })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_contact_info_passed)
  end
end