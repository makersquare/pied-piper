require 'spec_helper'

describe StageChangeEvent do
  it "fails without a box history id" do
    result = StageChangeEvent.run({})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_box_history_passed)
  end

  it "adds a job to resque queue" do
    Resque.stub(:enqueue).with(StageChangeEvent, {box_history_id: 5})
    result = StageChangeEvent.run({box_history_id: 5})
    expect(result.success?).to eq(true)
  end
end
