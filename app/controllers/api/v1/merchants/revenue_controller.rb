class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).revenue(search_params)
    render json: {"revenue"=> format_money(revenue)}
  end

  private

  def search_params
    if params[:date]
      date = Date.parse(params[:date])
      {created_at: date.beginning_of_day..date.end_of_day}
    end
  end

end
