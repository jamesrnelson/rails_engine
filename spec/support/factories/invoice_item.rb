FactoryBot.define do
  factory :invoice_item do
    invoice
    item
    quantity 4
    unit_price "2500"
    created_at Time.now
    updated_at Time.now
  end
end
