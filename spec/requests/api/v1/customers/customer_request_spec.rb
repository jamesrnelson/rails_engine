require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)
    expect(customers.count).to eq(3)
  end

  it 'can show an individual customer' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_success

    customer = JSON.parse(response.body)
    expect(customer['id']).to eq(id)
  end

  it 'can find single object for params' do
    create(:customer)
    first_name = 'Jimmy'
    create(:customer, first_name: first_name)

    get "/api/v1/customers/find?first_name=#{first_name}"
    expect(response).to be_success

    customer = JSON.parse(response.body)
    expect(customer['first_name']).to eq(first_name)
  end

  it 'can find all objects for params' do
    create_list(:customer, 3, first_name: 'Jimmy')
    first_name = 'Margaret'
    create_list(:customer, 5 ,first_name: first_name)

    get "/api/v1/customers/find_all?first_name=#{first_name}"
    expect(response).to be_success

    customers = JSON.parse(response.body)
    expect(customers.count).to eq(5)
    customers.each do |customer|
      expect(customer['first_name']).to eq(first_name)
    end
  end

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
