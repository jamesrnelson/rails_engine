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
end
