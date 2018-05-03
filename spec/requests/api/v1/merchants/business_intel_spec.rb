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

describe 'Merchants API ranked merchants by total revenue' do
  it 'returns a list of a variable number of merchants ranked by total revenue' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)
    item3 = create(:item, merchant_id: merchant3.id)
    item4 = create(:item, merchant_id: merchant4.id)
    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    invoice3 = create(:invoice, merchant_id: merchant3.id)
    invoice4 = create(:invoice, merchant_id: merchant4.id)
    create(:transaction, invoice: invoice1)
    create(:transaction, invoice: invoice2)
    create(:transaction, invoice: invoice3)
    create(:transaction, invoice: invoice4)
    create(:invoice_item, quantity: 10, unit_price: 10, item: item1, invoice: invoice1)
    create(:invoice_item, quantity: 8, unit_price: 8, item: item2, invoice: invoice2)
    create(:invoice_item, quantity: 2, unit_price: 2, item: item3, invoice: invoice3)
    create(:invoice_item, quantity: 1, unit_price: 1, item: item4, invoice: invoice4)

    quantity = 2
    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(quantity)
    expect(merchants.first['id']).to eq(merchant1.id)
  end
end
