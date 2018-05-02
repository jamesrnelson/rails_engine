require 'rails_helper'

describe 'Invoice Item' do
  context 'relationships' do
    it 'belongs to an invoice and an item' do
      invoice_item = create(:invoice_item)
      expect(invoice_item).to respond_to(:invoice)
      expect(invoice_item).to respond_to(:item)
    end
  end
end
