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

end
