include 'spec_helper'

describe ApiConversionScript do
  it_behaves_like('TransactionScripts')
  it 'fails if it cannot convert the inputs to a OpenStruct' do
    test = described_class.run('{ this is a test }')
    expect(test.error).to eq('failure to convert alert to OpenStruct')
  end
  it 'succeeds if it can convert the inputs to a OpenStruct' do
    test = described_class.run({ test:'this is a test' })
    expect(test.success?).to be_true
  end
end
