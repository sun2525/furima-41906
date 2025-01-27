class Item < ApplicationRecord
  # ユーザーと紐付ける（出品者を特定するため）

  belongs_to :user
  # ActiveStorageを利用して画像を添付できるようにする
  has_one_attached :image
  has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  # ActiveHashの関連付けを利用するためのモジュールを拡張
  # ActiveHashのモデルと関連付け
  belongs_to :category      # カテゴリー情報を関連付け
  belongs_to :condition     # 商品の状態を関連付け
  belongs_to :shipping_fee  # 配送料の負担を関連付け
  belongs_to :prefecture    # 発送元の地域を関連付け
  belongs_to :shipping_day  # 発送までの日数を関連付け

  # バリデーション（入力チェック）
  with_options presence: true do
    # 商品画像が添付されているかを確認
    validates :image, presence: true, unless: :image_attached?
    # 商品名が空でないかを確認
    validates :name
    # 商品説明が空でないかを確認
    validates :description
    # カテゴリーが「---」（ID: 1）以外を選択しているかを確認
    validates :category_id, numericality: { other_than: 1 }
    # 商品の状態が「---」（ID: 1）以外を選択しているかを確認
    validates :condition_id, numericality: { other_than: 1 }
    # 配送料の負担が「---」（ID: 1）以外を選択しているかを確認
    validates :shipping_fee_id, numericality: { other_than: 1 }
    # 発送元の地域が「---」（ID: 1）以外を選択しているかを確認
    validates :prefecture_id, numericality: { other_than: 1 }
    # 発送までの日数が「---」（ID: 1）以外を選択しているかを確認
    validates :shipping_day_id, numericality: { other_than: 1 }
    # 価格が指定の範囲内にあるかを確認
    validates :price, numericality: {
      greater_than_or_equal_to: 300, # 価格が300円以上
      less_than_or_equal_to: 9_999_999, # 価格が9,999,999円以下
      only_integer: true # 小数値の入力を制限する
    }
  end

  def image_attached?
    image.attached?
  end
end
