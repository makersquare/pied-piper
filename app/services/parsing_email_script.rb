class ParsingEmailScript < TransactionScript
  def run(inputs)
    @questions = [
      'First name',
      'First Name',
      'firstname',
      'first name',
      'last name',
      'Last name',
      'last name',
      'name',
      'Name',
      'NAME',
      'Email',
      'Email Address',
      'e-mail',
      'e-mail address',
      'phone number',
      'phonenumber',
      'Phone Number',
      'Phone number',
      'phone Number'
    ]
    info = parse(inputs.alert)
  end


  def parse(message)
    info = message.gsub(/>|\r/,'').map{|word| word.split(/\n/)}.map{|word| word.split(' ')}
    questions = @questions.map{|word| word.split(' ')}

    new_info = {}
    info.each_with_index do |sentence, index|
      if questions.include?(sentence)
        new_info[sentence.join(' ')] = info[index+1][0]
      end
    end

    new_info
  end

end
