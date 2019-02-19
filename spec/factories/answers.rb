FactoryBot.define do
  sequence :body_answer do |n|
    "Text Answer_#{n}"
  end

  factory :answer do
    body { 'MyText Answer' }
    question
    association :author, factory: :user

    factory :uniq_answer do
      body
      question
      association :author, factory: :user
    end
  end

  trait :invalid_answer do
    body { nil }
  end

  trait :edit_answer do
    body { 'New Body' }
  end
end
