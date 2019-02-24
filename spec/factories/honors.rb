FactoryBot.define do
  factory :honor do
    name { "MyString" }
    image { fixture_file_upload("#{Rails.root}/spec/fixtures/images/ruby.png") }
    question
  end
end
