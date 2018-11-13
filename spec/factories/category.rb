FactoryBot.define do
  factory :category do
    title { Faker::Lorem.word }
    description Faker::Lorem.sentence(3)
    permission_view 0
    status 0
  end
end
