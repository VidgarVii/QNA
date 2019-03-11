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

  trait :answer_with_link do
    after(:create) { |answer| create(:link, linkable: answer) }
  end

  trait :with_answer_gist do
    after(:create) { |answer| create(:link, :gist, linkable: answer) }
  end

  trait :with_answer_error_gist do
    after(:create) { |answer| create(:link, :error_gist, linkable: answer) }
  end

  trait :with_file do
    files { fixture_file_upload("#{Rails.root}/spec/rails_helper.rb") }
  end

  trait :with_answer_comment do
    after(:create) { |answer| create(:comment, commentable: answer, author: answer.author) }
  end

  trait :invalid_answer do
    body { nil }
  end

  trait :edit_answer do
    body { 'New Body' }
  end
end
