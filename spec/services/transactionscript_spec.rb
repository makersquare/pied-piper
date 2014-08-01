require 'spec_helper'

#please describe the transaction script class in the same way as below in order to
#maintain the form of the tests

#this refers to the transactionscript_spec_helper and needs to be used at the
#beginning of every transaction script.

shared_examples_for "TransactionScripts" do
  let(:current_script) { described_class.new }

  it "exists" do
    expect(described_class).to be_a(Class)
    expect(described_class.new).to be_a(TransactionScript)
  end

  it "can fail" do
    expect(current_script).to respond_to(:failure)
    result = current_script.failure("error_code")
    expect(result.success?).to eql(false)
    expect(result.error).to eql("error_code")
  end

  it "can fail with data" do
    result = current_script.failure("error_code", data: "someData")
    expect(result.success?).to eql(false)
    expect(result.error).to eql("error_code")
    expect(result.data).to eql("someData")
  end

  it "can succeed" do
    expect(current_script).to respond_to(:success)
    result = current_script.success(data: "somedata")
    expect(result.success?).to eql(true)
    expect(result.data).to eql("somedata")
  end

end

describe TransactionScript do
#this refers to the transactionscript_spec_helper and needs to be used at the
#beginning of every transaction script.
  it_behaves_like('TransactionScripts')
end
