require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it 'can show an individual item' do
    id = create(:item).id

    get "/api/v1/items/#{id}"
    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item['id']).to eq(id)
  end

  it 'can find single object for params' do
    create(:item, name: 'Jefferson Cup')
    name = 'Chris Long Sub'
    create(:item, name: name)

    get "/api/v1/items/find?name=#{name}"
    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item['name']).to eq(name)
  end

  it 'can find all objects for params' do
    create_list(:item, 3, name: 'Class Ring')
    name = 'Cyclops Burger'
    create_list(:item, 5, name: name)

    get "/api/v1/items/find_all?name=#{name}"
    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(5)
    items.each do |item|
      expect(item['name']).to eq(name)
    end
  end

  it 'can return a random item' do
    create_list(:item, 10)

    get '/api/v1/items/random'
    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item.class).to eq(Hash)
    expect(item.keys).to eq(%w[id name description unit_price merchant_id])
  end
end
