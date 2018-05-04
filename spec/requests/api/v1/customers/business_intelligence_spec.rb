require 'rails_helper'

describe 'Customers API' do
  it 'returns a merchant where the customer has conducted the most successful transactions' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, invoice: invoice)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"
    expect(response).to be_success

    fav_merchant = JSON.parse(response.body)
    expect(fav_merchant['id']).to eq(customer.favorite_merchant.id)
    expect(fav_merchant['id']).to eq(merchant.id)
  end
end
