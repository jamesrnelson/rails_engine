require 'rails_helper'

describe 'Items API relationships' do
  before(:each) do
    @item = create(:item)
  end

  it 'sends the associated merchant for a given item' do
    get "/api/v1/items/#{@item.id}/merchant"
    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant['id']).to eq(@item.merchant_id)
  end

  it 'sends the associated invoice items for a given item' do
    get "/api/v1/items/#{@item.id}/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)
    expect(invoice_items).to eq(@item.invoice_items)
  end
end
