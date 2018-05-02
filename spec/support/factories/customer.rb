FactoryBot.define do
  factory :customer do
    first_name 'Tommy'
    last_name 'Jefferson'
    created_at Time.now
    updated_at Time.now
  end
end
