require 'spec_helper'

describe RetrieveUserPipelines do

  it_behaves_like('TransactionScripts')

  describe 'Validation' do
    xit "requires a valid session" do
    end
  end

  it "Retrieves a users pipelines" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})
    p2 = CreatePipelineScript.run({:name=>'pipeline2'})
    p3 = CreatePipelineScript.run({:name=>'pipeline3'})

    u1 = User.create({name: 'Andrew'})
    u2 = User.create({name: 'DJ'})

    PipelineUser.create({user_id: u1.id, pipeline_id: p1.data.id})
    PipelineUser.create({user_id: u1.id, pipeline_id: p2.data.id})
    PipelineUser.create({user_id: u1.id, pipeline_id: p3.data.id})

    PipelineUser.create({user_id: u2.id, pipeline_id: p1.data.id})

    result1 = RetrieveUserPipelines.run(u1.id)
    result2 = RetrieveUserPipelines.run(u2.id)
    expect(result1.data.length).to eq(3)
    expect(result1.data[1].id).to eq(p2.data.id)
    expect(result2.data.length).to eq(1)
    expect(result2.data[0].id).to eq(p1.data.id)
  end
end