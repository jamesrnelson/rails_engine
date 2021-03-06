class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def revenue(filter={})
    invoice_items
    .joins(:transactions)
    .where(filter)
    .merge(Transaction.success)
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.ranked_revenue(limit = 5)
    select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
    .joins(:invoice_items)
    .order("total_revenue DESC")
    .group(:id)
    .limit(limit)
  end

  def self.all_revenue_by_date(filter = {})
    joins(invoice_items: [:invoice])
    .where(filter)
    .merge(Invoice.success)
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.most_items(x)
    select('merchants.*, sum(invoice_items.quantity) as item_quant')
    .joins(invoice_items: [:invoice])
    .merge(Invoice.success)
    .group('merchants.id')
    .order('item_quant DESC')
    .limit(x)
  end

  def favorite_customer
    customers
      .joins(:invoices)
      .joins(:transactions)
      .merge(Transaction.success)
      .group(:id)
      .order('COUNT(invoices.id) DESC')
      .first
  end
end
