require 'rails_helper'

describe 'Transaction' do
  context 'relationships' do
    it 'belongs to an invoice' do
      transaction = create(:transaction)
      expect(transaction).to respond_to(:invoice)
    end
  end
end
