class User < ActiveRecord::Base
  before_save :set_last_email_value
  #saves google outh user object to DB
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  has_many :pipeline_users
  has_many :pipelines, :through => :pipeline_users
  has_many :user_stages
  has_many :stages, through: :user_stages
  has_many :email_settings
  has_many :notifications

  def set_last_email_value
    self.last_email ||= Time.now
  end
end
