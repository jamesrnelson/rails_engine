class Api::V1::Transactions::SearchController < ApplicationController
  def show
    render json: Transaction.find_by(transaction_params)
  end

  private

  def transaction_params
    params.permit(:invoice_id, :credit_card_number, :result)
  end
end
