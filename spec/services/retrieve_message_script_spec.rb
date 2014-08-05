require 'spec_helper'

describe RetrieveMessageScript do
  it_behaves_like('TransactionScripts')

  before(:all) do
    @inputs = OpenStruct.new(secret_key: '123', message_data: {message_id: 1},alert: OpenStruct.new(account_id: 0))
  end

  it 'fails if the message is not a ContextIO::Message' do
    allow_any_instance_of(ContextIO).to receive(:accounts){[OpenStruct.new(messages: ['here is the message'])]}
    test = described_class.run(@inputs)
    expect(test.error).to eq('message content missing')
  end

  xit 'fails if the message body is not a string' do
    allow_any_instance_of(ContextIO).to receive(:accounts){[OpenStruct.new(messages: ['here is the message'])]}
    allow(is_?).to
    test = described_class.run(@inputs)
    expect(test.error).to eq('message not formatted correctly')
  end

end
