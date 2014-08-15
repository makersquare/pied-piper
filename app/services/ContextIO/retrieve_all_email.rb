include ContextioHelper

class RetrieveAllEmail < TransactionScript
  def run(contact)
    messages =[]
    Users.all.each do |user|
      account = ContextioHelper.account_email_signin(inputs[:user].email)
      user_messages = ContextioHelper.get_messages({ account:account, contact:contact, time: 4.weeks.ago.to_i })
      user_messages.each do |message|
        messages << { user_email: user.email, subject: message.subject, date: Time.at(message.date), message_id:message.message_id}
      end
    end
  success(contact: contact, messages: messages )
  end


end
