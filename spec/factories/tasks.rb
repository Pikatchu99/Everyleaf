FactoryBot.define do
  factory :task do
    name { "I'm title" }
    details {"I'm description"}
    expired_at { DateTime.now }
  end
end
