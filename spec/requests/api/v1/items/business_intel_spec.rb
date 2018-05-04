require 'rails_helper'

describe 'Items API' do
  it 'can return the top x item instances ranked by total number sold' do
    @item = create(:item)
    @item_2 = create(:item)
    invoice_item_1 = create(:invoice_item, item: @item, quantity: 10)
    invoice_item_2 = create(:invoice_item, item: @item, quantity: 30)
    invoice_item_3 = create(:invoice_item, item: @item_2, quantity: 2)
    invoice_item_4 = create(:invoice_item, item: @item_2, quantity: 3)
    invoice_item_5 = create(:invoice_item, item: @item_2, quantity: 4)
    create(:transaction, invoice_id: invoice_item_1.invoice_id)
    create(:transaction, invoice_id: invoice_item_2.invoice_id)
    create(:transaction, invoice_id: invoice_item_3.invoice_id)
    create(:transaction, invoice_id: invoice_item_4.invoice_id)
    create(:transaction, invoice_id: invoice_item_5.invoice_id)

    get "/api/v1/items/most_items?quantity=1"
    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.first['id']).to eq(@item.id)
    expect(items.length).to eq(1)
  end
  it 'returns the date with the most sales for a given item' do
    item = create(:item)
    get "/api/v1/items/#{item.id}/best_day"

    expect(response).to be_success
  end
end
