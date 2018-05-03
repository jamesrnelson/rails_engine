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
end
