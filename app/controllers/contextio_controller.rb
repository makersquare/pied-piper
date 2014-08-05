class ContextioController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:callback]

  def callback
    puts "callback action in contextio controller reached"
    puts params

    puts "API conversion script starting"
    contact = ApiConversionScript.run(params)
    puts contact unless contact.error.nil?

    puts "Api authentication script starting"
    contact = ApiAuthenticationScript.run(contact)
    puts contact unless contact.error.nil?

    puts "Retrieve message script starting"
    contact = RetrieveMessageScript.run(contact)
    puts contact unless contact.error.nil?

    puts "Parsing email script starting"
    contact = ParsingEmailScript.run(contact)
    puts contact unless contact.error.nil?

    puts contact
  end
end
