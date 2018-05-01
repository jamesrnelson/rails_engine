require 'rails_helper'

describe 'Merchant' do
  before(:each) do
    @merchant = create(:merchant)
  end
  context 'Relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end
  context 'instance methods' do
    it 'can return total revenue' do
      item_1 = create(:item, merchant_id: @merchant.id)
      item_2 = create(:item, merchant_id: @merchant.id)
      invoice_item_1 = create(:invoice_item, item: item_1)
      invoice_item_2 = create(:invoice_item, item: item_1)
      invoice_item_3 = create(:invoice_item, item: item_2)
      invoice_item_4 = create(:invoice_item, item: item_2)
      invoice_item_5 = create(:invoice_item, item: item_2)

      expect(@merchant.revenue).to eq(15000)
    end
  end
end
