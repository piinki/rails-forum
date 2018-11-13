FactoryBot.define do
  factory :user do
    first_name Faker::FunnyName.name
    last_name Faker::FunnyName.name
    password 123456
    email { Faker::Internet.email }

    trait :admin do
      role 2
    end
  end
end
