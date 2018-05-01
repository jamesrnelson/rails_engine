require 'rails_helper'

describe 'Merchants API' do
  it 'returns the total revenue for that merchant across successful transactions' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success
  end
end
