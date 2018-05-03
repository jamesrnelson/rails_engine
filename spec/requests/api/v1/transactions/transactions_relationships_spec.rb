require 'rails_helper'

describe 'Transactions API invoice relationship' do
  it 'sends the associated invoice for a given transaction' do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}/invoice"
    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice['id']).to eq(transaction.invoice_id)
  end
end
