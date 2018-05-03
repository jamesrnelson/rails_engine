require './lib/formatters/money_formatter'

class InvoiceItemSerializer < ActiveModel::Serializer
  include MoneyFormatter
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    format_money(object.unit_price)
  end
end
