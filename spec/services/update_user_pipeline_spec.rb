require 'spec_helper'

describe UpdateUserPipeline do

  it_behaves_like('TransactionScripts')

  it "Updates a user in a pipeline" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    user = User.create(name: 'Andrew', email: 'a@gmail.com')
    user_pipeline = AddUserPipeline.run(id: p1.data.id, user_id: user.id, pipeline_admin: true)

    result = UpdateUserPipeline.run(pipeline_id: p1.data.id, user_id: user.id, pipeline_admin: false)

    expect(result.success?).to eq(true)
    expect(result.data.admin).to eq(false)

    RemoveUserPipeline.run(pipeline_id: p1.data.id, user_id: user.id)
    result2 = UpdateUserPipeline.run(pipeline_id: p1.data.id, user_id: user.id, pipeline_admin: false)

    expect(result2.success?).to eq(false)
    expect(result2.error).to eq(:no_association_exists)
  end
end