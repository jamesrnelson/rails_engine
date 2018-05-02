FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number 1234567887654321
    result 'success'
    created_at Time.now
    updated_at Time.now
  end
end
