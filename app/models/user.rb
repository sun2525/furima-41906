class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネームが必須
  validates :nickname, presence: true

  # パスワードの条件: 半角英数字混合
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'must include both letters and numbers' }

  # 名前関連
  validates :last_name, :first_name, presence: true,
                                     format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'must be full-width characters' }
  validates :last_name_kana, :first_name_kana, presence: true,
                                               format: { with: /\A[ァ-ヶー]+\z/, message: 'must be full-width katakana characters' }

  # 生年月日が必須
  validates :birthday, presence: true

  has_many :items
end
