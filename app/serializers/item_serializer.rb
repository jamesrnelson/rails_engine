require './lib/formatters/money_formatter'

class ItemSerializer < ActiveModel::Serializer
  include MoneyFormatter
  attributes :description, :id, :merchant_id, :name, :unit_price

  def unit_price
    format_money(object.unit_price)
  end
end
