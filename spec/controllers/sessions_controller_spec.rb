require 'spec_helper'

describe SessionsController do

  let(:user) { User.new }

  before(:each) do
    allow(controller).to receive(:retrieve_oauth_user).and_return(user)
  end

  describe "GET sessions#create" do
    it "successfully redirects" do
      get :create
      expect(response).to be_redirect
      expect(response.request.fullpath).to eq("/sessions")
    end
  end

  describe "GET sessions#destroy'" do
    it "successfully redirects and signs out" do
      get :destroy
      expect(response).to be_redirect
      expect(response.request.fullpath).to eq("/signout")
    end
  end
end
