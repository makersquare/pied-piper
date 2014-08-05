class ContextioController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:callback]

  def callback
    contact = ApiConversionScript.run(params)
    puts contact unless contact.error.nil?

    contact = ApiAuthenticationScript.run(params)
    puts contact unless contact.error.nil?

    contact = RetrieveMessageScript.run(params)
    puts contact unless contact.error.nil?

    contact = ParsingEmailScript.run(params)
    puts contact unless contact.error.nil?

    puts contact
  end
end
