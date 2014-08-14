include ContextioHelper


class ContextioApiScript < ApplicationController

#this TX script runs all othe other contextio TX sscripts and passes on the errors
  def run(inputs)



#this authenticates the notification from contextio
    if inputs['signature'].nil?
      return failure 'Context.io authentication signature is nil'
    end
  #the webhook id is obtained when we create the webhook
    error = authenticate(inputs)

    return failure error if !error.nil?
#this retrieves the message body from contextio and returns the string containing the body
    account = account_signin(inputs['account_id'])
    message = get_message(inputs, account)

    return failure 'message content missing' unless message.is_a?(ContextIO::Message)

    text = select_message_text(message)

    return failure 'message not formatted correctly' unless text[:success]
    return failure 'message content not a string' unless text[:body].is_a?(String)
#this parses through the email and returns an openstruct containing the applicants
#information
    contact = parse_typeform(inputs.alert)

    return failure 'Missing firstname' if contact['firstname'].nil?
    return failure 'Missing lastname' if contact['lastname'].nil?
    return failure 'Missing email' if contact['email'].nil?

    return contact
  end
end
