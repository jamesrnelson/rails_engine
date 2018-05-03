require 'rails_helper'

describe 'Invoices API relationships' do
  it 'returns a collection of associated transactions for a single invoice' do
    invoice = create(:invoice)
    get "/api/v1/invoices/#{invoice.id}/transactions"
    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to eq(invoice.transactions)
  end
end
