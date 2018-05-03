class DropUnitPriceColumnFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :unit_price
  end
end
