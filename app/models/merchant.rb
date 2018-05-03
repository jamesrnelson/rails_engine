class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices

  def revenue(filter={})
    invoice_items
    .joins(:transactions)
    .where(filter)
    .merge(Transaction.success)
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def total_revenue(limit = 5)
    select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
    .joins(:transactions, :invoice_items)
    .merge(Transaction.success)
    .order("total_revenue DESC")
    .group(:id)
    .limit(limit)
  end
end

# Merchant.select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue').joins(:transactions, :invoice_items).merge(Transaction.success).order("total_revenue DESC").group(:id).limit(2)
