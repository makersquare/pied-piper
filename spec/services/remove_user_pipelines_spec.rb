require 'spec_helper'

describe RemoveUserPipeline do

  it_behaves_like('TransactionScripts')

  describe 'Validation' do
    # xit "requires a valid session" do
    # end
  end

  it "Removes a user from a pipeline, and makes sure they are in it" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    user = User.create(name: 'Andrew', email: 'a@gmail.com')
    user_pipeline = AddUserPipeline.run(id: p1.data.id, user_id: user.id, pipeline_admin: true)
    result = RemoveUserPipeline.run(pipeline_id: p1.data.id, user_id: user.id)

    expect(result.success?).to eq(true)
    expect(result.data.user_id).to eq(user.id)

    result2 = RemoveUserPipeline.run(id: p1.data.id, user_id: user.id)

    expect(result2.success?).to eq(false)
    expect(result2.error).to eq(:user_not_in_pipeline)
  end
end