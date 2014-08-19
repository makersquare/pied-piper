include ContextioHelper

class RetrieveAllEmail < TransactionScript
  def run(contact)

    messages =[]
    User.all.each do |user|
      begin
      account = ContextioHelper.account_email_signin(inputs[:user].email)
        user_messages = ContextioHelper.get_messages({ account:account, contact:contact, time: 4.weeks.ago.to_i })
      rescue
        user_messages=[]
      end
      user_messages.each do |message|
        messages << { user_email: user.email, subject: message.subject, date: Time.at(message.date), message_id:message.message_id}
      end
    end
    if messages == []
      account = ContextioHelper.account_email_signin('devpiedpiper@gmail.com')
        user_messages = ContextioHelper.get_messages({ account:account, contact:OpenStruct.new(email:'jered.mccullough@gmail.com'), time: 1.weeks.ago.to_i })
      user_messages.each do |message|
        messages << { user_email: 'devpiedpiper@gmail.com', from: message.from, subject: message.subject, date: Time.at(message.date), message_id:message.message_id }
      end
    end

    success(messages: messages)
  end

end
