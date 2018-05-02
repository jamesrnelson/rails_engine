class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items

  def revenue
    invoice_items.
    joins(invoice: :transactions).
    merge(Transaction.success).
    sum('invoice_items.unit_price * quantity')
  end

end
