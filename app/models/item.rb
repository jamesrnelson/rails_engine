class Item < ApplicationRecord
  default_scope { order(:id) }
  belongs_to :merchant
  has_many :invoice_items

  def self.top_quantity(x)
    select('items.*, invoice_items.quantity')
    .joins(:invoice_items)
    .order('invoice_items.quantity DESC')
    .limit(x)
  end
end
