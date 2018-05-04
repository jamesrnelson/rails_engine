require 'rails_helper'

describe 'Customers API' do
  it 'returns a merchant where the customer has conducted the most successful transactions' do
    customer = create(:customer)
    get "/api/v1/customers/#{customer.id}/favorite_merchant"

  end
end
