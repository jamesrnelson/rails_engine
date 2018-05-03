require 'rails_helper'

describe Item do
  context 'Relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
  end
  context 'class methods' do
    before(:each) do
      @item = create(:item)
      @item_2 = create(:item)
      invoice_item_1 = create(:invoice_item, item: @item, quantity: 10)
      invoice_item_2 = create(:invoice_item, item: @item, quantity: 30)
      invoice_item_3 = create(:invoice_item, item: @item_2, quantity: 2)
      invoice_item_4 = create(:invoice_item, item: @item_2, quantity: 3)
      invoice_item_5 = create(:invoice_item, item: @item_2, quantity: 4)
      create(:transaction, invoice_id: invoice_item_1.invoice_id)
      create(:transaction, invoice_id: invoice_item_2.invoice_id)
      create(:transaction, invoice_id: invoice_item_3.invoice_id)
      create(:transaction, invoice_id: invoice_item_4.invoice_id)
      create(:transaction, invoice_id: invoice_item_5.invoice_id)
    end
    it 'can return the top items by quantity' do
      expect(Item.top_quantity(1)).to eq([@item])
      expect(Item.top_quantity(2).length).to eq(2)
    end
  end
end
