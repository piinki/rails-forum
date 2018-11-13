FactoryBot.define do
  factory :topic do
    association :creator, factory: :user
    association :category
  end
end
