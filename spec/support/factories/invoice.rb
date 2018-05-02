FactoryBot.define do
  factory :invoice do
    status 'shipped'
    created_at Time.now
    updated_at Time.now
  end
end
