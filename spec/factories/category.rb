FactoryBot.define do
  factory :category do
    title { Faker::Lorem.word }
    description { "avcauiadhuihiuh"}
    permission_view { 0 }
    status { 0 }
  end
end
