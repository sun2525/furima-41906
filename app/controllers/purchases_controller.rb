class PurchasesController < ApplicationController
  # 購入するアイテムを特定するためのメソッドを、indexとcreateアクション実行前に呼び出し
  before_action :set_item, only: [:index, :create]
  
  before_action :authenticate_user! # ユーザーがログインしているかを確認

  before_action :redirect_if_invalid_access  # 出品者または売却済みならリダイレクト

  def index
    # 購入済み商品の場合はトップページへリダイレクト
    if @item.purchase.present?
      redirect_to root_path
    else
      # PurchaseAddressオブジェクトを新規作成（購入ページに表示されるフォーム用）
      @purchase_address = PurchaseAddress.new
    end
  end

  def create
    # フォームから送られたデータを基にPurchaseAddressオブジェクトを作成
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    binding.pry
    # バリデーションが成功した場合のみ保存を実行
    if @purchase_address.valid?
      @purchase_address.save
      # 保存が成功したらトップページにリダイレクトし、購入完了メッセージを表示
      redirect_to root_path
    else
      # 保存が失敗した場合、購入ページを再表示
      render :index, status: :unprocessable_entity
    end
  end

  private

  # 購入対象のアイテムを取得するメソッド
  def set_item
    @item = Item.find(params[:item_id])
  end

  # 購入フォームから送信されたパラメータを許可し、追加情報をマージするメソッド
  def purchase_address_params
    params.require(:purchase_address).permit(
      :postal_code,       # 郵便番号
      :prefecture_id,     # 都道府県
      :city,              # 市区町村
      :street_address,    # 番地
      :building_name,     # 建物名（任意）
      :phone_number       # 電話番号
    ).merge(
      user_id: current_user.id,  # ログイン中のユーザーIDを追加
      item_id: @item.id        # 購入対象アイテムのIDを追加
      # token: params[:token]      # トークン情報を追加（クレジットカード処理用）
    )
  end
  
  def redirect_if_invalid_access
    # 条件1: 出品者がアクセスしようとした場合
    # 条件2: 売却済みの商品にアクセスしようとした場合
    if current_user == @item.user || @item.purchase.present?
      redirect_to root_path
    end
  end
end
