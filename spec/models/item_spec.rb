require 'rails_helper'

describe 'Item' do
  it 'belongs to a merchant' do
    item = create(:item)
    expect(item).to respond_to(:merchant)
  end
end
