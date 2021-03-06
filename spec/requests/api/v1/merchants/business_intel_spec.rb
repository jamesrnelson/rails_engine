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
  before(:each) do
    @merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    item1 = create(:item, merchant_id: @merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)
    item3 = create(:item, merchant_id: merchant3.id)
    item4 = create(:item, merchant_id: merchant4.id)
    invoice1 = create(:invoice, merchant_id: @merchant1.id)
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
  end
  it 'returns a list of a variable number of merchants ranked by total revenue' do
    quantity = 2
    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(quantity)
    expect(merchants.first['id']).to eq(@merchant1.id)
  end
  it 'returns the top x merchants ranked by total number of items sold' do
    get '/api/v1/merchants/most_items?quantity=3'
    expect(response).to be_success
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
    expect(merchants.first['id']).to eq(@merchant1.id)
  end
end

describe 'Merchants API gross revenue for all merchants for a specific date' do
  it 'returns a single value of the gross revenue for that date' do
    date = "2011-05-20"
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)
    invoice1 = create(:invoice, merchant_id: merchant1.id, created_at: date)
    invoice2 = create(:invoice, merchant_id: merchant2.id, created_at: date)
    create(:transaction, invoice: invoice1)
    create(:transaction, invoice: invoice2)
    create(:invoice_item, quantity: 10, unit_price: 10, item: item1, invoice: invoice1)
    create(:invoice_item, quantity: 8, unit_price: 8, item: item2, invoice: invoice2)

    get "/api/v1/merchants/revenue?date=#{date}"

    expect(response).to be_success

    gross_revenue = JSON.parse(response.body)
    expect(gross_revenue.class).to eq(Hash)
    expect(gross_revenue['total_revenue']).to eq('1.64')
  end
end

describe 'Merchants API favorite customer' do
  it 'returns a customer who has the most successful transactions for a given merchant' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, invoice: invoice)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    expect(response).to be_success

    fav_customer = JSON.parse(response.body)
    expect(fav_customer['id']).to eq(merchant.favorite_customer.id)
    expect(fav_customer['id']).to eq(customer.id)
  end
end
