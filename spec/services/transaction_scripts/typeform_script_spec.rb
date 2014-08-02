require_relative '../../app/services/triggers/typeform_script.rb'
require 'spec_helper'


describe PP::TypeFormTrigger do

  describe "checking the API response" do
    let(:script) { PP::TypeFormTrigger.new }

    before(:each) do
      contact =
        {
          id: "4287",
          completed: "1",
          token: "d3bbd31ff9b4d91dc3cf15d903615951",
          locked: "0",
          metadata: {
            browser: "default",
            platform: "other",
            date_land: "2014-04-21 19:43:34",
            date_submit: "2014-04-21 19:53:04",
            user_agent: "Mozilla\/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit\/537.36 (KHTML, like Gecko) Chrome\/34.0.1847.116 Safari\/537.36",
            referer: "http:\/\/www.themakersquare.com\/faq",
            network_id: "b4acf382aada324638372d6b56630a8790ba2272"
            },
          hidden: [ ],
          answers: {
            textfield_270020: "Jonathan",
            textfield_270021: "Katz",
            email_270025: "jonathan.a.katz@gmail.com",
            textfield_270022: "6109992648",
            textfield_365745: "Philadelphia, PA",
            list_348229_choice_1174542: "",
            list_348229_choice_1262622: "",
            list_617183_choice_868624: "",
            list_617183_choice_868625: "",
            list_617183_choice_868626: "JavaScript",
            list_617183_choice_868627: "",
            list_617183_choice_868628: "",
            list_617183_choice_868629: "Ruby",
            list_617183_choice_868630: "",
            list_617183_choice_868631: "",
            list_617183_choice_868653: "",
            list_617183_other: "",
            textarea_659617: "Codeschool, CodeAcademy, Why's Poignant Guide to Ruby, Humble Little Ruby Book, Eloquent Javascript, Eloquent Ruby, Coderbyte",
            textarea_270027: "http:\/\/www.codecademy.com\/textblaster29970\ \ https:\/\/www.codeschool.com\/users\/katzinthehats\ \ ",
            textfield_561563: "http:\/\/www.linkedin.com\/pub\/jonathan-katz\/26\/853\/264\/",
            textarea_561689: "https:\/\/drive.google.com\/file\/d\/0B1ZIdDhJih4RSFBaQVIzVEtJaWc\/edit?usp=sharing",
            yesno_397177: "1",
            textarea_714066: "I discovered MakerSquare via Bootcamper.io",
            textfield_270024: "",
            textfield_270023: "Skype: jonathan.a.katz"
          }
        }
      expect(script).to receive(:api_call).and_return(contact)
    end

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
