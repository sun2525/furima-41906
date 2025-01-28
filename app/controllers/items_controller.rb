class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :redirect_if_not_owner, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order(created_at: :desc) # 商品を取得して変数に格納
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end

  # 対象の@itemを取得
  def set_item
    @item = Item.find(params[:id])
  end

  # 出品者以外をトップページにリダイレクト
  def redirect_if_not_owner
    unless current_user == @item.user
      redirect_to root_path, alert: "不正なアクセスです。"
    end
  end
end
