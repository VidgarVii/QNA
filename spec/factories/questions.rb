FactoryBot.define do
  sequence :title do |n|
    "Title_#{n}"
  end

  sequence :body do |n|
    "Body_#{n}"
  end

  factory :question do
    title { "MyString" }
    body { "MyText" }

    factory :uniq_question do
      title
      body
    end
  end

  trait :invalid_question do
    title { nil }
  end

  trait :edit_question do
    title { "New Title" }
    body { "New Body" }
  end

  trait :with_answers do
    transient { count_answers { 5 } }

    after(:create) { |question, evaluator| create_list(:answer, evaluator.count_answers, question: question) }
  end
end
