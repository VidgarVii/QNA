FactoryBot.define do
  factory :comment do
    body { "Comment" }
    association :commentable, factory: :answer
  end
end
