require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
  end

  it 'can show an individual merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant['id']).to eq(id)
  end

  it 'can find single object for params' do
    create(:merchant, name: 'Coupes')
    name = 'The Virginian'
    create(:merchant, name: name)

    get "/api/v1/merchants/find?name=#{name}"
    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant['name']).to eq('The Virginian')
  end

  it 'can find all objects for params' do
    create_list(:merchant, 3, name: 'The Lawn')
    name = 'Rotunda'
    create_list(:merchant, 5, name: name)

    get "/api/v1/merchants/find_all?name=#{name}"
    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(5)
    merchants.each do |merchant|
      expect(merchant['name']).to eq(name)
    end
  end

  it 'can return a random merchant' do
    create_list(:merchant, 10)

    get '/api/v1/merchants/random'
    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant.class).to eq(Hash)
    expect(merchant.keys).to eq(['id', 'name'])
  end
end
