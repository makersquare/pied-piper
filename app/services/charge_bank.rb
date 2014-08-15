require 'balanced'

class ChargeBank < TransactionScript
  def run(params)
    Balanced.configure('ak-test-1HCvxVKYmjTc7NqUaEBDhFhJZQp4P9CX7')

    bank_account = Balanced::BankAccount.fetch(params['uri'])
    verification = bank_account.verify

    verification.confirm(
      amount_1 = 1,
      amount_2 = 1
    )

    payee = Contact.find_by(email: params['email'])

    if bank_account.nil?
      return failure('incorrect bank account info')
    end

    if payee.nil?
      return failure('why are you trying to give us money? you havent applied')
    end

    result = bank_account.debit(
      :amount => 13000,
      :appears_on_statement_as => 'Statement text',
      :description => 'Your soul is ours! hahaha'
    )

    return success(charge_info: result.attributes)
  end
end
