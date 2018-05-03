class ItemSerializer < ActiveModel::Serializer
  attributes :description, :id, :merchant_id, :name, :unit_price

  def unit_price
    '%.2f' % (object.unit_price.to_f / 100)
  end
end
