# app/models/purchase_address.rb
class PurchaseAddress
  include ActiveModel::Model
  # フォームで入力される属性を定義
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, 
                :building_name, :phone_number, :user_id, :item_id, :token

  # バリデーションの設定
  with_options presence: true do
    # 郵便番号が必須で、「3桁ハイフン4桁」の形式のみ許可
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/}
    
    # 都道府県が必須（0は選択されていない状態として無効にする）
    validates :prefecture_id, numericality: { other_than: 1 }
    
    # 市区町村が必須
    validates :city
    
    # 番地が必須
    validates :street_address
    
    # 電話番号が必須、10桁以上11桁以内の半角数値のみ許可
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    
    # トークンが必須（クレジットカード情報のトークン）
    validates :token
    
    # ユーザーIDと商品IDも必須
    validates :user_id
    validates :item_id
  end

  # フォーム送信後の保存処理
  def save
    # 購入情報を保存し、purchaseに代入
    purchase = Purchase.create(user_id: user_id, item_id: item_id)

    # 配送先情報を保存
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building_name: building_name,
      phone_number: phone_number,
      purchase_id: purchase.id
    )
  end
end
