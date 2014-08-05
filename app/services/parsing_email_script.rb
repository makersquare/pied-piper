class ParsingEmailScript < TransactionScript
  def run(inputs)
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
    success info
  end


  def parse(message)
    body = message.downcase.gsub(/>|\r/,'')
    info = body.split(/\n/).map{|word| word.split(' ')}
    questions = @questions.map{|word| word.split(' ')}

    new_info = {}
    new_info['body'] = body
    info.each_with_index do |sentence, index|
      if questions.include?(sentence)
        new_info[sentence.join('')] = info[index+1][0].capitalize
      end
    end

    new_info
  end

end
