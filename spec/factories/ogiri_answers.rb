FactoryBot.define do
  factory :ogiri_answer do
    ogiri_answer { Faker::Lorem.characters(number: 30) }
  end
end