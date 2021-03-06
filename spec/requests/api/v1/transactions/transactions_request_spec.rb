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

  it 'can find all objects for params' do
    create_list(:transaction, 3, result: 'success')
    result = 'failed'
    create_list(:transaction, 5 , result: result)

    get "/api/v1/transactions/find_all?result=#{result}"
    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(5)
    transactions.each do |transaction|
      expect(transaction['result']).to eq(result)
    end
  end

  it 'can return a random transaction' do
    create_list(:transaction, 10)

    get '/api/v1/transactions/random'
    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction.class).to eq(Hash)
    expect(transaction.keys). to eq(['id', 'invoice_id', 'credit_card_number', 'result'])
  end
end
