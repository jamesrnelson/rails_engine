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

  def best_day
    invoices
      .merge(Invoice.success)
      .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoice_items)
      .group('invoices.created_at')
      .order('revenue DESC')
      .first
      .created_at
  end

  def self.ranked_revenue(limit = 5)
    select('items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
    .joins(:invoice_items)
    .order("total_revenue DESC")
    .group(:id)
    .limit(limit)
  end
end
