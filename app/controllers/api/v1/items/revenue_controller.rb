class Api::V1::Items::RevenueController < ApplicationController
  def index
    render json: Item.ranked_revenue(params[:quantity])
  end
end
