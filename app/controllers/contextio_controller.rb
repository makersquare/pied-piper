class ContextioController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:callback]

#This controller is for the Contextio notification post
  def callback
    ContextioApiScript.run(params)
    render nothing: true
  end
end
