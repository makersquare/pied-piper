class AddUserToContextio < TransactionScript
  def run(user)
    name = user.name.split(' ')
    account = create_new_account(email: user.email, first_name: name[0], last_name: name[1..-1].join(' '))
    create_new_source(account: account, email: user.email, server: imap.gmail.com, username: user.email, use_ssl: 1, port: 993, type:'IMAP', provider_refresh_token: user.oath_token)
  end
end
