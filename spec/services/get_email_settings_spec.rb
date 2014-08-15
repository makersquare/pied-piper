require 'spec_helper'

describe GetEmailSettings do

  before(:all) do
    @user1 = User.create(name: "Gabe", email: "gabe@gmail.com")
    @user2 = User.create(name: "Catherine", email: "catherine@gmail.com")
    @pipeline1 = Pipeline.create(name: "Admissions")
    @pipeline2 = Pipeline.create(name: "Recruiters")
    @pipeline_user1 = PipelineUser.create(user_id: @user1.id, pipeline_id: @pipeline1.id, admin: true)
    @pipeline_user2 = PipelineUser.create(user_id: @user2.id, pipeline_id: @pipeline2.id, admin: true)
    @setting1 = EmailSettings.create(pipeline_user_id: @pipeline_user1.id)
    @setting2 = EmailSettings.create(pipeline_user_id: @pipeline_user2.id, setting: "Noemails")
  end

  after(:all) do
    User.destroy_all
    EmailSettings.destroy_all
    Pipeline.destroy_all
  end

  xit "returns settings given a user_id" do
    params = {:pipeline_user => @pipeline_user1 }
    settings = GetEmailSettings.run(params)

    expect(settings[0][:pipeline_name]).to eq("Admissions")
    expect(settings[1][:pipeline_name]).to eq("Recruiters")
    expect(settings[0]["setting"]).to eq("Realtime")
    expect(settings[1]["setting"]).to eq("Noemails")
  end

end
