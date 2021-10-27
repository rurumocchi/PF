FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 20) }
    sequence(:encrypted_password) { |n| "000000" }
    sequence(:profile_image_id) { |n| "000000" }
  end
end