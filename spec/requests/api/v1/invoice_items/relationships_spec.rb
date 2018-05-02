require 'rails_helper'

describe 'Invoice Items API relationships' do
  before(:each) do
    @invoice_item = create(:invoice_item)
  end

  it 'sends the associated invoice for a given invoice_item' do
    get "/api/v1/invoice_items/#{@invoice_item.id}/invoice"

    expect(response).to be_success

    invoice = JSON.parse(response.body)
    expect(invoice['id']).to eq(@invoice_item.invoice_id)
  end

  it 'sends the associated item for a given invoice_item' do
    get "/api/v1/invoice_items/#{@invoice_item.id}/item"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item['id']).to eq(@invoice_item.item_id)
  end
end
