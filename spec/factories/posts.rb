FactoryBot.define do
  factory :post do
    sequence(:title){|n| Faker::Job.title + "#{n}"}
    body {Faker::Job.field + "hi" *25}
    association(:user, factory: :user)
  end
end
