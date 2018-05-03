class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    offset = rand(InvoiceItem.count)
    render json: InvoiceItem.offset(offset).limit(1).first
  end
end
