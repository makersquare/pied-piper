class ContextioController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

#This controller is for the Contextio notification post
  def create
    ContextioApiScript.run(params)
    render nothing: true
  end

  def retrieve_email
    RetrieveAllEmail.run(Contact.find(params[:contact_id]))
  end
end
