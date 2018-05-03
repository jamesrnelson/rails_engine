require 'rails_helper'

describe 'Merchants API' do
  before(:each) do
    @merchant = create(:merchant)
    item_1 = create(:item, merchant_id: @merchant.id)
    item_2 = create(:item, merchant_id: @merchant.id)
    invoice = create(:invoice)
    @invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice)
    invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice)
    invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice)
    invoice_item_4 = create(:invoice_item, item: item_2, invoice: invoice)
    invoice_item_5 = create(:invoice_item, item: item_2, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)
  end
  it 'returns the total revenue for that merchant across successful transactions' do
    get "/api/v1/merchants/#{@merchant.id}/revenue"

    expect(response).to be_success

    revenue = JSON.parse(response.body)
    expected = '%.2f' % (@merchant.revenue.to_f / 100)
    expect(revenue['revenue']).to eq(expected)
  end
  it 'returns the total revenue for that merchant across successful transactions for a given date' do
    get "/api/v1/merchants/#{@merchant.id}/revenue?date=#{@invoice_item_1.created_at}"

    expect(response).to be_success

    revenue = JSON.parse(response.body)
    expected = '%.2f' % (@merchant.revenue(created_at: @invoice_item_1.created_at).to_f / 100)
    expect(revenue['revenue']).to eq(expected)
  end
end
