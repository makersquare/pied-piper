require 'spec_helper'

describe ChargeCredit do
  it_behaves_like('TransactionScripts')

  it 'fails if input is not a hash' do
    test = described_class.run('{ this is a test }')
    expect(test.error).to eq('Api POST request formatted incorrectly')
  end

  it 'succeeds if it can convert the inputs to a OpenStruct' do
    test = described_class.run({ test:'this is a test' })
    expect(test.success?).to be_true
  end
end
