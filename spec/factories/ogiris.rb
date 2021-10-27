FactoryBot.define do
  factory :ogiri do
    answer { Faker::Lorem.characters(number: 15) }
    ogiri_odai { Faker::Lorem.characters(number: 20) }
  end
end