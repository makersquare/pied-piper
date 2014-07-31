#these tests are for all different transaction scripts
#to run these tests include it_behaves_like('TransactionScripts') at beginning
#of your spec tests.

shared_examples_for "TransactionScripts" do
#this will create a new instance of the described Transanction Script
  let(:current_script) { described_class.new }

#these tests make sure it conforms to the basic form a Transaction script
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
