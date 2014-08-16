include ContextioHelper


class ContextioApiScript < TransactionScript

#this TX script runs all othe other contextio TX sscripts and passes on the errors
  def run(inputs)
#this authenticates the notification from contextio
    if inputs['signature'].nil?
      return failure :Contextio_authentication_signature_is_nil
    end
  #the webhook id is obtained when we create the webhook
    error = ContextioHelper.authenticate(inputs)
    return failure error if !error.nil?
    user = User.find_by(webhook_id: inputs['webhook_id'])
#this retrieves the message body from contextio and returns the string containing the body
    account = ContextioHelper.account_signin(inputs['account_id'])
    message_id = inputs['message_data']['message_id']
    message = ContextioHelper.get_message({message_id:message_id, account:account})

    return failure :message_content_missing unless message.is_a?(ContextIO::Message)

    text = ContextioHelper.select_message_text(message)

    return failure :message_not_formatted_correctly unless text[:success]
    return failure :message_content_not_a_string unless text[:body].is_a?(String)
#this parses through the email and returns an openstruct containing the applicants
#information
    body = ContextioHelper.parse_typeform(text)

    return failure :Missing_firstname if body['firstname'].nil?
    return failure :Missing_email if body['email'].nil?

    contact = CreateContact.run(body)

    return contact unless contact.success
    contact = contact.contact
    pipeline = Pipeline.find_by(name:'Admissions')
    stage = Stage.find_by(pipeline_location:1,pipeline_id:pipeline.id)
    box = AddContactToPipeline.run(contact_id:contact.id, stage_id:stage.id, pipeline_location:stage.pipeline_location, pipeline_id:pipeline.id)
    return box unless success

    note_info = {contact_id: contact.id, notes:body['body'], user_id: user.id, pipeline_id:pipeline.id}
    note = CreateNote.run(note_info)
    return note unless success

    return success contact: contact
  end
end
