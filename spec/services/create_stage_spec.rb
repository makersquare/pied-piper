require 'spec_helper'

describe CreateStage do

  it_behaves_like('TransactionScripts')
  let(:script) {CreateStage.new}

  describe 'Validation' do

    # xit "requires a valid session" do
    # end
  end

  it "creates a stage within a pipeline" do
    p1 = CreatePipelineScript.run({:name=>'pipeline1'})

    result1 = CreateStage.run({:pipeline_id=> p1.data.id, :name=>'Application started', :description=>'Individual has started filling out an application', :pipeline_location=>1})
    result2 = CreateStage.run({:pipeline_id=> p1.data.id, :name=>'Application submitted', :description=>'Individual has submitted application for review', :pipeline_location=>2})

    stage1 = result1.data
    stage2 = result2.data

    expect(result1.success?).to eq(true)
    expect(stage1.id).to_not be(nil)
    expect(stage1.name).to eq('Application started')
    expect(stage1.description).to eq('Individual has started filling out an application')
    expect(stage1.pipeline_id).to eq(p1.data.id)
    expect(stage1.pipeline_location).to eq(1)

    expect(result2.success?).to eq(true)
    expect(stage2.id).to_not be(nil)
    expect(stage2.name).to eq('Application submitted')
    expect(stage2.description).to eq('Individual has submitted application for review')
    expect(stage2.pipeline_id).to eq(p1.data.id)
    expect(stage2.pipeline_location).to eq(2)
  end

end
