FactoryBot.define do
  factory :item do
    name 'good ole song'
    description 'we come from old virginia where all is bright and gay'
    unit_price '100'
    merchant
    created_at Time.now
    updated_at Time.now
  end
end
