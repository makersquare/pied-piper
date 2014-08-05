require 'spec_helper'

describe ApiAuthenticationScript do
  it_behaves_like('TransactionScripts')

  it 'fails if the signature is nil' do
    alert = described_class.run({ 'signature'=> nil, 'webhook_id'=>'53dc3db6b4810f6c699076d3', 'timestamp'=> 1, 'token'=>'2a' })
    expect(alert.error).to eq('Context.io authentication signature is nil')

  end

  it 'fails if the signature is incorrect' do
    alert = described_class.run({ 'signature'=> 123, 'webhook_id'=>'53dc3db6b4810f6c699076d3', 'timestamp'=> 1, 'token'=>'2a' })
    expect(alert.error).to eq('Context.io notification authentication failure')
  end

  it 'fails if the webhook_id is nil' do
    alert = described_class.run({'signature'=> "505c8c5374be13aef8463c001d67aa79b3315431b65eb6140eabff3dfcf3815e", 'webhook_id'=> nil, 'timestamp'=> 1, 'token'=>'2a'})
    expect(alert.error).to eq('Context.io webhook id not recognized')
  end

  it 'fails if the webhook_id is incorrect' do
    alert = described_class.run({'signature'=> "505c8c5374be13aef8463c001d67aa79b3315431b65eb6140eabff3dfcf3815e", 'webhook_id'=> 123, 'timestamp'=> 1, 'token'=>'2a'})
    expect(alert.error).to eq('Context.io webhook id not recognized')
  end

  it 'succeeds if both webhook_id and signature are correct' do
    alert = described_class.run({'signature'=> "505c8c5374be13aef8463c001d67aa79b3315431b65eb6140eabff3dfcf3815e", 'webhook_id'=> '53dc3db6b4810f6c699076d3', 'timestamp'=> 1, 'token'=>'2a'})
    expect(alert.success?).to be_true
  end
end
