include ContextioHelper

class RetrieveAllEmail < TransactionScript
  def run(contact)
    messages =[]
    Users.all.each do |user|
      user_messages = get_messages({ user:user, contact:contact, time: 4.weeks.ago.to_i }})
      user_messages.each do |message|
        messages << { user_email: user.email, subject: message.subject, date: Time.at(message.date), message_id:message.message_id}
      end
    end
  success { contact: contact, messages: messages }
  end


end
