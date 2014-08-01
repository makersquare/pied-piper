require 'spec_helper'

describe Pipeline do
  describe 'validation' do
    it "requires a non-nil username" do
      use_case = CreatePipelineScript.new
      result = use_case.run(name: nil)

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:name_nil)
    end

    it "requires a non-blank username" do
      use_case = CreatePipelineScript.new
      result = use_case.run(name: '')

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
  end
end
