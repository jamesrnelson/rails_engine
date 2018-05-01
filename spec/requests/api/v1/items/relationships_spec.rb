require 'rails_helper'

describe 'Items API relationships' do
  before(:each) do
    @item = create(:item)
  end

  it 'sends the associated merchant for a given item' do
    get "api/v1/items/#{@item.id}/merchant"
    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant['id']).to eq(@item.merchant_id)
  end
end
