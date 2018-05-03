require 'rails_helper'

describe 'Customers API invoices relationships' do
  it 'sends the associated invoices for a given customer' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}/invoices"
    expect(response).to be_success

    invoices = JSON.parse(response.body)

    invoices.each do |invoice|
      expect(invoice['customer_id']).to eq(customer.id)
    end

    expect(invoices).to eq(customer.invoices)
  end
end

describe 'Customers API transactions relationship' do
  it 'sends the associated transactions for a given customer' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}/transactions"
    expect(response).to be_success

    transactions = JSON.parse(response.body)
  end
end
