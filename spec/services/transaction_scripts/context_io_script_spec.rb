inlcude 'spec_helper'
  it_behaves_like('TransactionScripts')

description 'context_io' do

  context 'recieves a notification from context_io webhook' do
    it 'authenticates that the request came from context.io' do
      expect(desc)
    end

    it 'parses the notification into a hash' do
    end

    it 'confirms that it is the correct type of notification for typeform' do
    end

    it 'parses the email body into a hash' do
    end

  end


  it 'sends the info to the api transaction scripts' do

  end

end
