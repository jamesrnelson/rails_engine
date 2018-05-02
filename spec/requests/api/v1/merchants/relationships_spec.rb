require 'rails_helper'

describe 'Merchants API item relationships' do
  it 'sends the associated items for a given merchant' do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_success

    items = JSON.parse(response.body)

    items.each do |item|
      expect(item['merchant_id']).to eq(merchant.id)
    end

    expect(items).to eq(merchant.items)
  end
end

describe 'Merchants API invoice relationship' do
  it 'sends the associated invoices for a given merchant' do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    invoices.each do |invoice|
      expect(invoice['merchant_id']).to eq(merchant.id)
    end

    expect(invoices).to eq(merchant.items)
  end
end
