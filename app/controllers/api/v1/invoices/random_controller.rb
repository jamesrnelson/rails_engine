class Api::V1::Invoices::RandomController < ApplicationController
  def show
    offset = rand(Invoice.count)
    render json: Invoice.offset(offset).limit(1).first
  end
end
