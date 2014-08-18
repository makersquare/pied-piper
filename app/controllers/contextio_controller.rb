class ContextioController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token, :only => [:callback]
#This controller is for the Contextio notification post
  def callback
    ContextioApiScript.run(params)
    render nothing: true
  end
  def getemail
    contact = Contact.find(email_params[:id])
    result = RetrieveAllEmail.run(contact)
    if result.success?
      respond_with result: result.messages
    else
      respond_with result.error
    end
  end

  def email_params
    params.permit(:id, :format)
  end
end
