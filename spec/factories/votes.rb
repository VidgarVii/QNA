FactoryBot.define do
  factory :vote do
    state { 0 }
    user
    rating
  end
end
