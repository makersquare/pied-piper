


class ContextioApiScript < ApplicationController

#this TX script runs all othe other contextio TX sscripts and passes on the errors
  def run(inputs)

#this tests and converts the input into a hash
    contact = ApiConversionScript.run(inputs)
    return contact unless contact.error.nil?

#this authenticates the notification from contextio
    if inputs['signature'].nil?
      return failure 'Context.io authentication signature is nil'
    end

  #the webhook id is obtained when we create the webhook
    error = authenticate(inputs)

    return failure error if !error.nil?

#this retrieves the message body from contextio and returns the string containing the body
    contact = RetrieveMessageScript.run(contact)
    return contact unless contact.error.nil?

#this parses through the email and returns an openstruct containing the applicants
#information
    contact = ParsingEmailScript.run(contact)

    return contact
  end
end
