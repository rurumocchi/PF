FactoryBot.define do
  factory :ogiri_comment do
    comment { Faker::Lorem.characters(number: 50) }
  end
end
