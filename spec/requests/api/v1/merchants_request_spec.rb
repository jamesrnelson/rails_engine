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
    create_list(:merchant, 3)
    name = 'The Virginian'
    create(:merchant, name: name)

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['name']).to eq('The Virginian')
  end
end
