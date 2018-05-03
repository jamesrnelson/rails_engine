class Api::V1::Items::RandomController < ApplicationController
  def show
    offset = rand(Item.count)
    render json: Item.offset(offset).limit(1).first
  end
end
