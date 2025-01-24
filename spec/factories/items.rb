FactoryBot.define do
  factory :item do
    name { 'テスト商品' }
    description { 'テスト商品説明' }
    category_id { Faker::Number.between(from: 2, to: 10) } # カテゴリーID（2〜10のランダムな値）
    condition_id { Faker::Number.between(from: 2, to: 6) } # 状態ID（2〜6のランダムな値）
    shipping_fee_id { Faker::Number.between(from: 2, to: 3) } # 配送料負担（2〜3のランダムな値）
    prefecture_id { Faker::Number.between(from: 2, to: 47) } # 都道府県（2〜47のランダムな値）
    shipping_day_id { Faker::Number.between(from: 2, to: 4) } # 発送までの日数（2〜4のランダムな値）
    price { Faker::Number.between(from: 300, to: 9_999_999) } # 価格（300〜9,999,999のランダムな値）

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
