class Api::V1::Merchants::GrossRevenueController < ApplicationController
  def show
    render json: Merchant.gross_revenue(search_params)
    
  end
end
