class ItemsController < ApplicationController
  # ログイン状態でのみアクセス可能なアクションを指定
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # 対象の商品を取得するbefore_actionを追加
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # 出品者以外はアクセスできないようにリダイレクトするbefore_action
  before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]

  # 売却済み商品の編集・更新を制限
  before_action :redirect_if_sold_out, only: [:edit, :update]

  # 商品一覧ページ
  def index
    @items = Item.includes(:user).order(created_at: :desc) # 商品を取得して変数に格納
  end

  # 商品出品ページ
  def new
    @item = Item.new
  end

  # 商品出品処理
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path # 出品成功後、トップページにリダイレクト
    else
      render :new, status: :unprocessable_entity # 出品失敗時、エラー表示
    end
  end

  # 商品詳細ページ
  def show
    # set_item で @item を取得済み
  end

  # 商品編集ページ
  def edit
    # set_item で @item を取得済み
  end

  # 商品更新処理
  def update
    # set_item で @item を取得済み
    if @item.update(item_params)
      redirect_to item_path(@item) # 更新成功後、商品詳細ページにリダイレクト
    else
      render :edit, status: :unprocessable_entity # 更新失敗時、エラー表示
    end
  end

  # 商品削除処理
  def destroy
    @item.destroy # 商品削除
    redirect_to root_path # 削除後、トップページにリダイレクト
  end

  private

  # Strong Parameters - 商品情報を許可する
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id) # 出品者IDを加える
  end

  # 対象の商品を取得
  def set_item
    @item = Item.find(params[:id]) # URLのIDから商品を取得
  end

  # 出品者以外をトップページにリダイレクト
  def redirect_if_not_owner
    return if current_user == @item.user # 出品者が一致していれば処理を進める

    redirect_to root_path # 出品者でなければトップページにリダイレクト
  end

  def redirect_if_sold_out
    # 商品が売却済み（購入情報が存在する）場合はトップページへリダイレクト
    return unless @item.purchase.present?

    redirect_to root_path
  end
end
