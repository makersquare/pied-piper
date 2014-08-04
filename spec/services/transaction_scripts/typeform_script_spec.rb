require_relative '../../app/services/triggers/typeform_script.rb'
require 'spec_helper'


describe TypeFormTrigger do

  describe "checking the API response" do

    it "is a correct API call" do
      result = script.run
      expect(result).to_not be_nil
    end

    it "checks name" do
      result = script.run
      expect(result).to eq(nil)
      expect(result.success?).to eq(true)
    end

    it "checks email" do
      result = script.run
      expect(result.success?).to eq(true)
    end

    xit "checks phone" do
    end

    xit "checks location" do
    end

    xit "checks cohort" do
    end

    xit "checks languages" do
    end

    xit "checks linkedin profile" do
    end

    xit "checks skype/google account" do
    end

    context "the typeform API does not return correct information" do
    end

    context "the typeform API returns correct information" do
      xit "creates an instance of a contact model" do
      end

      xit "assigns the contact to a pipeline" do

      end
    end
  end
end
