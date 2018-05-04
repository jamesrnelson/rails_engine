class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants
      .joins(:invoices)
      .joins(:transactions)
      .merge(Transaction.success)
      .group(:id)
      .order('COUNT(invoices.id) DESC')
      .first
  end
end
