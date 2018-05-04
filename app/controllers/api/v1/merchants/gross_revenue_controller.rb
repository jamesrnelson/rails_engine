class Api::V1::Merchants::GrossRevenueController < ApplicationController
  def show
    gross_revenue = Merchant.all_revenue_by_date(search_params)
    render json: { total_revenue: format_money(gross_revenue) }
  end

  private

  def search_params
    if params[:date]
      date = Date.parse(params[:date])
      { invoices: { created_at: date.beginning_of_day..date.end_of_day } }
    end
  end
end
