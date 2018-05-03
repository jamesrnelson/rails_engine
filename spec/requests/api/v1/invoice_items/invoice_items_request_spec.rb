require 'rails_helper'

describe 'Invoice Items API' do
  it 'sends a list of invoice items' do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'
    expect(response).to be_success

    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)
  end

  it 'can show an individual invoice item' do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body)
    expect(invoice_item['id']).to eq(id)
  end

  it 'can find single invoice item given params' do
    create(:invoice_item, quantity: 7777)
    quantity = 1819
    create(:invoice_item, quantity: quantity)

    get "/api/v1/invoice_items/find?quantity=#{quantity}"
    expect(response).to be_success

    invoice_item = JSON.parse(response.body)
    expect(invoice_item['quantity']).to eq(quantity)
  end

  it 'can find all invoices items for given params' do
    create_list(:invoice_item, 3, unit_price: 676767)
    unit_price = 2011
    create_list(:invoice_item, 5, unit_price: unit_price)

    get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"
    expect(response).to be_success

    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(5)
    invoice_items.each do |invoice_item|
      expect(invoice_item['unit_price']).to eq(unit_price)
    end
  end

  it 'can return a random invoice_item' do
    create_list(:invoice_item, 10)

    get '/api/v1/invoice_items/random'
    expect(response).to be_success

    invoice_item = JSON.parse(response.body)

    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item.keys).to eq(
      %w[id invoice_id item_id quantity unit_price]
    )
  end
end
