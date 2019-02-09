FactoryBot.define do
  factory :answer do
    question
    body { 'MyText' }
  end

  trait :invalid_answer do
    body { nil }
  end

  trait :edit_answer do
    body { 'New Body' }
  end
end
