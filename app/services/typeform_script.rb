#this takes the output from the context_io notification and parses it for the information to
#input into the database and pipline

class TypeFormTrigger < TransactionScript
  # def run(inputs)
  #   contact = parse_message_text(inputs.alert)
  #   unless contact.is_a?(Contact)
  #     return failure(error: 'email text could not be parsed correctly')
  #   end
  #   return success ({ alert: contact })
  # end

  # def parse_message_text(text)
  #   questions =[
  #     "First name",
  #     "first name",
  #     "First Name",
  #     "first Name",
  #     "first_name",
  #     "FIRST NAME",
  #     "Last name",
  #     "last_name",
  #     "Last Name",
  #     "last Name",
  #     "LAST NAME",
  #     "Email",
  #     "E-mail",
  #     "email",
  #     "e-mail",
  #   ]
  # end

end
