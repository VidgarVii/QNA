FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
  end

  trait :invalid_question do
    title { nil }
  end

  trait :edit_question do
    title { "New Title" }
    body { "New Body" }
  end
end
