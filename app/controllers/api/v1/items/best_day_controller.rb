class Api::V1::Items::BestDayController < ApplicationController
  def show
    best_day = Item.find(params[:id]).best_day
    render json: { "best_day": best_day }
  end
end
