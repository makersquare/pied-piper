class ParsingEmailScript < TransactionScript
  def run(inputs)
  end

  def parse(email)
    email = email.split(/\n/)
    list = []
    info = {}
    email.each_with_index do |w, index|
      if questions.include?(w)
        list<<index
      end
    end

    list.each do |num|
      info[email[num]] = email[num+1]
    end


  end

end
