require 'rails_helper'

describe Merchant do
  before(:each) do
    @merchant = create(:merchant)
  end
  describe 'Relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
  end
  context 'instance methods' do
    it 'can return total revenue' do
      item_1 = create(:item, merchant_id: @merchant.id)
      item_2 = create(:item, merchant_id: @merchant.id)
      invoice = create(:invoice)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice)
      invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice)
      invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice)
      invoice_item_4 = create(:invoice_item, item: item_2, invoice: invoice)
      invoice_item_5 = create(:invoice_item, item: item_2, invoice: invoice)
      transaction = create(:transaction, invoice: invoice)

      expect(@merchant.revenue).to eq(50000)
    end
  end
end
