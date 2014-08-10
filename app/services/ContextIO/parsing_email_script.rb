class ParsingEmailScript < TransactionScript

  #this script parses through the email and extracts contact info
  def run(inputs)

  #these questions are the requirements for a contact entity we can move these out to be
  #altered later if we want
    @questions = [
      'firstname',
      'first name',
      'last name',
      'name',
      'e-mail',
      'e-mail address',
      'email',
      'phone number',
      'phonenumber',
    ]


    info = parse(inputs.alert)

    return failure 'Missing firstname' if info['firstname'].nil?
    return failure 'Missing lastname' if info['lastname'].nil?
    return failure 'Missing email' if info['email'].nil?

  #return success with the contact info if it passes
    success info
  end


  def parse(message)

  #this downcases the message for easier parsing and removes > and \r characters
  #then we store the body in order to save it as a note later
    body = message.downcase.gsub(/>|\r/,'')

  #we split the body into an array of lines to parse it line by line and then split each
  #line into an array of words
    info = body.split(/\n/).map{|word| word.split(' ')}

  #we split each question into an array of words to compare it to the body
    questions = @questions.map{|word| word.split(' ')}

    new_info = {}
  #we are storing the body text in the has to retrieve it for a note later
    new_info['body'] = body

  #cycle through the body to match the questions
    info.each_with_index do |sentence, index|
      if questions.include?(sentence)
        #we compare each array of question words to each array of words in the body then we
        #return the matching lines as a key to the value containing the next line
        new_info[sentence.join('')] = info[index+1][0].capitalize
      end
    end
  #return the body hash containing the name, body, email, and maybe the phone number
    new_info
  end

end
