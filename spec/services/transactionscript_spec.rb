describe TransactionScript do

  it "exists" do
    expect(TransactionScript).to be_a(Class)
  end

  let(:obj) { TransactionScript.new }

  it "can fail" do
    expect(obj).to respond_to(:failure)
    result = obj.failure("error_code")
    expect(result.success?).to eql(false)
    expect(result.error).to eql("error_code")
  end

  it "can fail with data" do
    result = obj.failure("error_code", data: "someData")
    expect(result.success?).to eql(false)
    expect(result.error).to eql("error_code")
    expect(result.data).to eql("someData")
  end

  it "can succeed" do
    expect(obj).to respond_to(:success)
    result = obj.success(data: "somedata")
    expect(result.success?).to eql(true)
    expect(result.data).to eql("somedata")
  end



end
