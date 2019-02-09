FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
  end

  trait :invalid do
    title { nil }
  end

  trait :edit do
    title { "New Title" }
    body { "New Body" }
  end
end
