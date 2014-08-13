require 'spec_helper'

describe AddUserPipeline do

  it_behaves_like('TransactionScripts')

  describe 'Validation' do
    xit "requires a valid session" do
    end
  end

  it "Adds a user to a pipeline and bounces back if the user is already in it" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    user = User.create(name: 'Andrew', email: 'a@gmail.com')

    result = AddUserPipeline.run(id: p1.data.id, user_id: user.id, pipeline_admin: true)

    expect(result.success?).to eq(true)
    expect(result.data["user_id"]).to eq(user.id)
    expect(result.data["pipeline_id"]).to eq(p1.data.id)
    expect(result.data["admin"]).to eq(true)

    result2 = AddUserPipeline.run(id: p1.data.id, user_id: user.id, pipeline_admin: true)
    expect(result2.success?).to eq(false)
    expect(result2.error).to eq(:user_already_in_pipeline)
  end
end