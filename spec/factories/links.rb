FactoryBot.define do
  factory :link do
    name { "rusrails" }
    url { "http://rusrails.ru" }
  end

  trait :gist do
    name { "gist" }
    url { "https://gist.github.com/VidgarVii/5d57bfba7d270fe169a8189fa5c28575" }
  end

  trait :error_gist do
    name { "gist" }
    url { "https://gist.github.com/VidgarVii/a4907205d4fe891000232f26cf06c2fd" }
  end
end
