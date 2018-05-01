FactoryBot.define do
  factory :invoice do
    status 'shipped'
    customer
    merchant
    created_at Time.now
    updated_at Time.now
  end
end
