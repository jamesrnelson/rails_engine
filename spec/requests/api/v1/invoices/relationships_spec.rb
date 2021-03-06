require 'rails_helper'

describe 'Invoices API relationships' do
  before(:each) do
    @invoice = create(:invoice)
  end
  it 'returns a collection of associated transactions for a single invoice' do
    get "/api/v1/invoices/#{@invoice.id}/transactions"
    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to eq(@invoice.transactions)
  end
  it 'returns a collection of associated invoice items for a single invoice' do
    get "/api/v1/invoices/#{@invoice.id}/invoice_items"
    expect(response).to be_success

    invoice_items = JSON.parse(response.body)
    expect(invoice_items).to eq(@invoice.invoice_items)
  end
  it 'returns a collection of associated items for a single invoice' do
    get "/api/v1/invoices/#{@invoice.id}/items"
    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items).to eq(@invoice.items)
  end
  it 'returns the associated customer for an invoice' do
    get "/api/v1/invoices/#{@invoice.id}/customer"
    expect(response).to be_success

    customer = JSON.parse(response.body)
    expect(customer['id']).to eq(@invoice.customer.id)
  end
  it 'returns the associated merchant for an invoice' do
    get "/api/v1/invoices/#{@invoice.id}/merchant"
    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant['id']).to eq(@invoice.merchant.id)
  end

end
