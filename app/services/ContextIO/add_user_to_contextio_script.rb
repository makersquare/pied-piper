class AddUserToContextio < TransactionScript
  def run(user)
    contextio = ContextIO.new(ENV['CONTEXTIO_APIKEY'], ENV['CONTEXTIO_SECRETKEY'])
    name = user.name.split(' ')
    account = contextio.accounts.new(email: user.email, first_name: name[0], last_name: name[1..-1].join(' '))
    account.sources.create(email: user.email, server: imap.gmail.com, username: user.email, use_ssl: 1, port: 993, type:'IMAP', provider_refresh_token: user.oath_token)
  end
end
