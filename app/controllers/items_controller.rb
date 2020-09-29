class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, except: [:index, :new, :create]

  def index
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end 
  end

  def edit
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      binding.pry
      redirect_to root_path
    else
      binding.pry
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name, 
      :price, 
      :description, 
      :size_id, 
      :category_id, 
      :brand, 
      :condition_id, 
      :shipping_fee_id, 
      :handling_time_id, 
      :prefecture_id, 
      :status, 
      images_attributes: [:image, :_destroy, :id]
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
