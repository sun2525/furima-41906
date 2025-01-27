Rails.application.routes.draw do
  devise_for :users # Deviseによるユーザー認証ルート

  # アイテム関連のルート
  resources :items, only: [:new, :create, :index, :show, :edit, :update]

  # ルートページの設定
  root to: "items#index"
end