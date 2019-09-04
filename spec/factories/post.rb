FactoryBot.define do
  factory :post do
    association :topic
    content {Faker::Lorem.sentence(3)}
    association :user

    trait :root do
      is_root {true}
    end
  end
end
