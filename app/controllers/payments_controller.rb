class PaymentsController < ApplicationController
  respond_to :json

  def create
    binding.pry
    result = ChargeCredit.run(params)
    binding.pry
    respond_to do |format|
      format.json do
        if result.success?
          respond_with result.charge_info
        else
          respond_with result.error, status: :unprocessable_entity
        end
      end
      format.js do
        if result.success?
          respond_with result.charge_info
        else
          respond_with result.error, status: :unprocessable_entity
        end
      end
    end
  end
end


