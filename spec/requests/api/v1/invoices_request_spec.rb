require 'rails_helper'

describe 'Invoices API' do
  it 'sends a list of invoices' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, customer_id: customer.id, merchant_id: merchant.id)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(3)
  end

  it 'can show an individual invoice' do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer_id: customer.id, merchant_id: merchant.id).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)
    expect(invoice['id']).to eq(id)
  end
end
