require 'rails_helper'

describe 'Items API' do
  before(:each) do
    @item = create(:item)
    @item_2 = create(:item)
    @day = '2018-01-20T01:00:00.000Z'
    invoice = create(:invoice, created_at: @day)
    invoice_item_1 = create(:invoice_item, item: @item, quantity: 10)
    @invoice_item_2 = create(:invoice_item, item: @item, quantity: 30, invoice: invoice)
    invoice_item_3 = create(:invoice_item, item: @item_2, quantity: 2)
    invoice_item_4 = create(:invoice_item, item: @item_2, quantity: 3)
    invoice_item_5 = create(:invoice_item, item: @item_2, quantity: 4)
    create(:transaction, invoice_id: invoice_item_1.invoice_id)
    create(:transaction, invoice_id: @invoice_item_2.invoice_id)
    create(:transaction, invoice_id: invoice_item_3.invoice_id)
    create(:transaction, invoice_id: invoice_item_4.invoice_id)
    create(:transaction, invoice_id: invoice_item_5.invoice_id)
  end
  it 'can return the top x item instances ranked by total number sold' do
    get "/api/v1/items/most_items?quantity=1"
    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.first['id']).to eq(@item.id)
    expect(items.length).to eq(1)
  end
  it 'returns the date with the most sales for a given item' do
    get "/api/v1/items/#{@item.id}/best_day"
    expect(response).to be_success

    date = JSON.parse(response.body)
    expect(date['best_day']).to eq(@day)
  end
end

describe 'Item API ranked items by total revenue' do
  it 'returns a list of a variable number of items ranked by total revenue' do
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
    get "/api/v1/items/most_revenue?quantity=#{quantity}"

    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(quantity)
    expect(items.first['id']).to eq(item1.id)
  end
end
