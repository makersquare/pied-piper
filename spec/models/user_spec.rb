require 'spec_helper'
require 'hashie'

describe User do
  describe 'self.from_omniauth' do
    context "when user already exits" do
      it "returns an existing User object with info filled in" do
        user = User.create(uid: "1111111111111111", provider: "google_oauth2")
        auth_string = File.read('spec/models/response.rb')
        auth = eval(auth_string)
        auth_mash = Hashie::Mash.new(auth)

        result = User.from_omniauth(auth_mash)

        expect(result.id).to eq user.id
        expect(result.uid).to be_a String
        expect(result.email).to be_a String
      end
    end

    context "when database is empty" do
      it "allows the addition of a first user" do

        User.destroy_all
        auth_string = File.read('spec/models/response.rb')
        auth = eval(auth_string)
        auth_mash = Hashie::Mash.new(auth)

        result = User.from_omniauth(auth_mash)

        expect(result.id).to eq user.id
        expect(result.uid).to be_a String
        expect(result.email).to be_a String
      end

    end
  end
end
