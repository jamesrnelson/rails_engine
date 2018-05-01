require 'rails_helper'

describe 'Invoice' do
  it 'belongs to merchant and a customer' do
    invoice = create(:invoice)
    expect(invoice).to respond_to(:merchant)
    expect(invoice).to respond_to(:customer)
  end
end
