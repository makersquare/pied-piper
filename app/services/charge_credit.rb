require 'balanced'

class ChargeCredit < TransactionScript
  def run(params)
    Balanced.configure('ak-test-1HCvxVKYmjTc7NqUaEBDhFhJZQp4P9CX7')

    card = Balanced::CardHold.fetch(params['uri'])
    payee = Contact.find_by(email: params['email'])

    if card.nil?
      return failure('incorrect credit card info')
    end

    if payee.nil?
      return failure('why are you trying to give us money? you havent applied')
    end

    result = card.debit(
      :amount => 13000,
      :appears_on_statement_as => 'Statement text',
      :description => 'Your soul is ours! hahaha'
    )

    return success(charge_info: result.attributes)
  end
end
