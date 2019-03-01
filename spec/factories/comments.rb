FactoryBot.define do
  factory :comment do
    body { "Comment" }
    commentable { nil }
  end
end
