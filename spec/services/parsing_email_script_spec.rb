require 'spec_helper'

describe ParsingEmailScript do

  it_behaves_like('TransactionScripts')

  it 'fails if there is no first name' do
    input=OpenStruct.new(
      alert:(
<<EOS
              last name
              devani
              email
              devpiedpiper@gmail.com
              phonenumber
              7078403998
EOS
))
    result = described_class.run(input)
    expect(result.error).to eq('Missing firstname')
  end
  it 'fails if there is no last name' do
    input=OpenStruct.new(
      alert:(
<<EOS
              firstname
              Shehzan
              email
              devpiedpiper@gmail.com
              phonenumber
              7078403998
EOS
))
    result = described_class.run(input)
    expect(result.error).to eq('Missing lastname')
  end

  it 'fails if there is no email address field' do
    input=OpenStruct.new(
      alert:(
<<EOS
              firstname
              Shehzan
              last name
              devani
              phonenumber
              7078403998
EOS
))
    result = described_class.run(input)
    expect(result.error).to eq('Missing email')

  end

  it 'succeeds if all fields pass' do
    input=OpenStruct.new(
      alert:(
<<EOS
              firstname
              Shehzan
              last name
              devani
              email
              devpiedpiper@gmail.com
              phonenumber
              7078403998
EOS
))
    result = described_class.run(input)
    expect(result.success?).to be_true
  end
end
