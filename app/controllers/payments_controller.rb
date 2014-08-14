class PaymentsController < ApplicationController
  respond_to :json

  def create
    binding.pry
    if params['type'] == 'credit'
      result = ChargeCredit.run(params)
    else
      result = ChargeBank.run(params)
    end

    if result.success?
      respond_with result.charge_info, :location => '/#/pipelines'
    else
      respond_with result.error, status: :unprocessable_entity
    end
  end
end


