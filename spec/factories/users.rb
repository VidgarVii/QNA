FactoryBot.define do
  sequence :email do |n|
    "test#{n}@mail.ru"
  end

  factory :user do
    email
    password { 'qwerty' }
    password_confirmation { 'qwerty' }
  end
end
