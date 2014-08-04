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

    context "when a user doesn't exit" do
      it "returns a new User object with info filled in" do
        # shouldn't have to manually clear this, but not deleting the values created above^
        User.destroy_all

        auth_string = File.read('spec/models/response.rb')
        auth = eval(auth_string)
        auth_mash = Hashie::Mash.new(auth)

        existing_user_check = User.find_by(uid: auth_mash.uid, provider: auth_mash.provider)
        result = User.from_omniauth(auth_mash)

        expect(existing_user_check).to eq(nil)
        expect(result.uid).to be_a String
        expect(result.email).to be_a String
      end
    end
  end
end
