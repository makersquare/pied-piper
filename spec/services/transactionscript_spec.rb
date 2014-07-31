describe TransactionScript do

  it "exists" do
    expect(TransactionScript).to be_a(Class)
  end
  it "can fail" do
    obj = TransactionScript.new
    expect(obj).to respond_to(:failure)
    result = obj.failure("error_code")
    expect(result[:success?]).to eql(false)
    expect(result[:error]).to eql("error_code")
  end
  it "can succeed" do
    obj = TransactionScript.new
    expect(obj).to respond_to(:success)
    result = obj.success("somedata")
    expect(result[:success?]).to eql(true)
    expect(result[:data]).to eql("somedata")
  end



end
