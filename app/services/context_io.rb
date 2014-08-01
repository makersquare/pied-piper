require 'contextio'

contextio = ContextIO.new('hmsdfr9u', 'AGDc0NnvjJicuwaA')

account = contextio.accounts.where(email: 'devpiedpiper@gmail.com').first

account.messages.where(from: 'jeredmccullough@gmail.com')
