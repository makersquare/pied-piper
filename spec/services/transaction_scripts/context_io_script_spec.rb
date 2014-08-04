include 'spec_helper'

description ContextIOTrigger do
  it_behaves_like('TransactionScripts')

  before(:each) do
    stub_const("secret_key", 1)
    stub_const("contextio", 'newcontextio')
    stub_const("account_id", 1)
    stub_const('account', 'new_account')
    stub_const('message', 'new_message')
  end

  it 'fails if the message is not a ContextIO::Message' do
    test = described_class.run(inputs)
    expect(test.error).to eq('message content missing')
  end

  it 'fails if the message body is not a string' do
    expect(test.error).to eq('message not formatted correctly')
  end

end
