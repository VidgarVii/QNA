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
    association :author, factory: :user

    factory :uniq_question do
      title
      body
    end
  end

  trait :with_honor do
    association :honor, factory: :honor
  end

  trait :with_files do
    files { fixture_file_upload("#{Rails.root}/spec/rails_helper.rb") }
  end

  trait :invalid_question do
    title { nil }
  end

  trait :edit_question do
    title { "New Title" }
    body { "New Body" }
  end

  trait :with_link do
    after(:create) { |question| create(:link, linkable: question) }
  end

  trait :with_comment do
    after(:create) { |question| create(:comment, commentable: question, author: question.author) }
  end

  trait :with_quest_gist do
    after(:create) { |question| create(:link, :gist, linkable: question) }
  end

  trait :with_quest_error_gist do
    after(:create) { |question| create(:link, :error_gist, linkable: question) }
  end

  trait :with_answers do
    transient { count_answers { 5 } }

    after(:create) { |question, evaluator| create_list(:uniq_answer, evaluator.count_answers, question: question) }
  end
end
