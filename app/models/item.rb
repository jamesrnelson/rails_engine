class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.top_quantity(x)
    select('items.*, sum(invoice_items.quantity) as item_quant')
    .joins(invoice_items: [:invoice])
    .merge(Invoice.success)
    .group('items.id')
    .order('item_quant DESC')
    .limit(x)
  end
end
