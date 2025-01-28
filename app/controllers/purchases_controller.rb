class PurchasesController < ApplicationController
  # 購入するアイテムを特定するためのメソッドを、indexとcreateアクション実行前に呼び出し
  before_action :set_item, only: [:index, :create]
  
  # ユーザーがログインしているかを確認
  before_action :authenticate_user!

  def index
    # 購入済み商品の場合はトップページへリダイレクト
    if @item.purchase.present?
      redirect_to root_path, alert: 'この商品はすでに購入されています。'
    else
      # OrderAddressオブジェクトを新規作成（購入ページに表示されるフォーム用）
      @order_address = OrderAddress.new
    end
  end

  def create
    # フォームから送られたデータを基にOrderAddressオブジェクトを作成
    @order_address = OrderAddress.new(order_address_params)
    
    # バリデーションが成功した場合のみ保存を実行
    if @order_address.valid?
      @order_address.save
      # 保存が成功したらトップページにリダイレクトし、購入完了メッセージを表示
      redirect_to root_path, notice: '購入が完了しました。'
    else
      # 保存が失敗した場合、購入ページを再表示
      render :index
    end
  end

  private

  # 購入対象のアイテムを取得するメソッド
  def set_item
    @item = Item.find(params[:item_id])
  end

  # 購入フォームから送信されたパラメータを許可し、追加情報をマージするメソッド
  def order_address_params
    params.require(:order_address).permit(
      :postal_code,       # 郵便番号
      :prefecture_id,     # 都道府県
      :city,              # 市区町村
      :street_address,    # 番地
      :building_name,     # 建物名（任意）
      :phone_number       # 電話番号
    ).merge(
      user_id: current_user.id,  # ログイン中のユーザーIDを追加
      item_id: @item.id,         # 購入対象アイテムのIDを追加
      token: params[:token]      # トークン情報を追加（クレジットカード処理用）
    )
  end
end
