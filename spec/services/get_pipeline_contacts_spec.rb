require 'spec_helper'

describe GetPipelineContacts do

  let(:script) {GetPipelineContacts.new}

  describe 'Validation' do

    xit "requires a valid session" do
    end
  end

  xit "returns a list of contacts in a given box" do
    # item_1 = DoubleDog.db.create_item(name: 'hot dog', price: 5)
    # item_2 = DoubleDog.db.create_item(name: 'fries', price: 3)
    # order_1 = DoubleDog.db.create_order(session_id: 'stubbed', items: [item_1, item_2])
    # order_2 = DoubleDog.db.create_order(session_id: 'stubbed', items: [item_2])

    # script = DoubleDog::SeeAllOrders.new
    # expect(script).to receive(:admin_session?).and_return(true)

    # result = script.run(admin_session: 'stubbed')

    # expect(result[:success?]).to eq(true)

    # orders = result[:orders]

    # expect(orders.count).to be >= 2
    # item_names = orders.map { |order| order.items.map &:name }.flatten
    # expect(item_names).to include('hot dog', 'fries')
    # expect(item_names.count).to eq(3)
  end

end
