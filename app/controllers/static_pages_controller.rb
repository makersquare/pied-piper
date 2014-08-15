class StaticPagesController < ApplicationController
  skip_before_action :validate_token, :only => [:login]

  def index
  end
  def login
    @supressNavbar = true
  end
end
