class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).revenue
    render json: {"revenue"=> format_money(revenue)}
  end
end
