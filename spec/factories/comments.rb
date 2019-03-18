FactoryBot.define do
  factory :comment do
    body { "Comment" }
    association :commentable, factory: :answer
    association :author, factory: :user
  end
end
