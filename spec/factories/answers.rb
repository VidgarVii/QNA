FactoryBot.define do
  sequence :body_answer do |n|
    "Text Answer_#{n}"
  end

  factory :answer do
    question
    body { 'MyText' }
  end

  trait :invalid_answer do
    body { nil }
  end

  trait :uniq_answer do
    body_answer
  end

  trait :edit_answer do
    body { 'New Body' }
  end
end
