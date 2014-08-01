require 'pry-byebug'

describe 'Create Pipeline' do
    it "requires a non-nil name" do
      use_case = CreatePipelineScript.new
      result = use_case.run(name: nil)

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:name_nil)
    end

    it "requires a non-blank name" do
      result = CreatePipelineScript.run(name: '')

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:name_empty)
    end

    it "requires a name to not be taken" do
      use_case = CreatePipelineScript.new
      result = use_case.run(name: 'Process Cows')
      result = use_case.run(name: 'Process Cows')
      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:name_taken)
    end

    it "Adds an entry to the db when there is no problem" do
      result = CreatePipelineScript.run(name: 'Andrew is great')
      expect(result.data.id).to be_a(Integer)
      expect(result[:success?]).to eq(true)
    end
  end

describe 'Update Pipeline' do
  it "requires a non-nil name" do
    use_case = CreatePipelineScript.new
    result = use_case.run(name: "Pipe1")
    expect(result.data.name).to eq("Pipe1")

    updated_result = UpdatePipelineName.run(id: result.data.id, name: nil)

    expect(updated_result[:success?]).to eq(false)
    expect(updated_result[:error]).to eq(:name_nil)
  end

  it "requires a non-blank name" do
    result = CreatePipelineScript.run(name: "Pipe1")
    expect(result.data.name).to eq("Pipe1")

    updated_result = UpdatePipelineName.run(id: result.data.id, name: '')

    expect(updated_result[:success?]).to eq(false)
    expect(updated_result[:error]).to eq(:name_empty)
  end

  it "requires a name to not be taken" do
    result = CreatePipelineScript.run(name: "Pipe3")
    expect(result.data.name).to eq("Pipe3")

    updated_result = UpdatePipelineName.run(id: result.data.id, name: 'Pipe3')

    expect(updated_result[:success?]).to eq(false)
    expect(updated_result[:error]).to eq(:name_taken)
  end

  it "Should change the name if there are no issues" do
    result = CreatePipelineScript.run(name: "Pipe3")
    expect(result.data.name).to eq("Pipe3")

    updated_result = UpdatePipelineName.run(id: result.data.id, name: 'Pipe5')
    expect(updated_result[:success?]).to eq(true)
    expect(updated_result.data.name).to eq('Pipe5')
  end
end