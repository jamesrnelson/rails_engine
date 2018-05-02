class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items

  def revenue(params={})
    invoice_items.where(params)
    joins(:transactions).
    where(status: "success").
    sum('unit_price * quantity')
  end

end
