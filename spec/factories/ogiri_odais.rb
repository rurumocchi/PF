FactoryBot.define do
  factory :ogiri_odai do
    odai_text { Faker::Lorem.characters(number: 20) }
  end
end
