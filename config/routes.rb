Rails.application.routes.draw do
  devise_for :users # Deviseによるユーザー認証ルート

  # アイテム関連のルート
  resources :items do
    resources :purchases, only: [:index, :create]
  end
  # ルートページの設定
  root to: "items#index"
end