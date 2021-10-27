FactoryBot.define do
  factory :ogiri_odai do
    odai_text { Faker::Lorem.characters(number: 20) }
    sequence(:genre_name) { |n| "TEST_odai_genre_name#{n}"}

  end
end