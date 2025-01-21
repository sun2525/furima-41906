FactoryBot.define do
  factory :user do
    nickname { 'suzuki' }
    email { Faker::Internet.unique.email }
    password { 'test1234' }
    password_confirmation { password }
    last_name { '鈴木' }
    first_name { '太郎' }
    last_name_kana { 'スズキ' }
    first_name_kana { 'タロウ' }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
