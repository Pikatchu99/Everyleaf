FactoryBot.define do
  factory :user do
    id {1}
    email { "test00@gmail.com" }
    name { "test00" }
    password { ".........." }
    is_admin {true}
  end
end
