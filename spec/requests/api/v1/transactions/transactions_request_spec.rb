require 'rails_helper'

describe 'Transactions API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(3)
  end

  it 'can show an individual transaction' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction['id']).to eq(id)
  end

  it 'can find single object for params' do
    create(:transaction, result: 'failed')
    result = 'success'
    create(:transaction, result: result)

    get "/api/v1/transactions/find?result=#{result}"
    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction['result']).to eq('success')
  end

  # it 'can find all objects for params' do
  #   create_list(:merchant, 3, name: 'The Lawn')
  #   name = 'Rotunda'
  #   create_list(:merchant, 5 ,name: name)
  #
  #   get "/api/v1/merchants/find_all?name=#{name}"
  #   expect(response).to be_success
  #
  #   merchants = JSON.parse(response.body)
  #   expect(merchants.count).to eq(5)
  #   merchants.each do |merchant|
  #     expect(merchant['name']).to eq(name)
  #   end
  # end
  #
  # it 'can return a random merchant' do
  #   create_list(:merchant, 10)
  #
  #   get '/api/v1/merchants/random'
  #   expect(response).to be_success
  #
  #   merchant = JSON.parse(response.body)
  #   expect(merchant.class).to eq(Hash)
  #   expect(merchant.keys). to eq(['id', 'name'])
  # end
end
