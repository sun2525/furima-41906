class Address < ApplicationRecord
  belongs_to :purchase
  # enum例：都道府県（`ActiveHash`を利用している場合）
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
