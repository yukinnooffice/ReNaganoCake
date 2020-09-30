class CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:show, :update, :destroy, :edit]
  before_action :set_customer

  def index
    @cart_items = @customer.cart_items.includes(:product)
    @total_price = @cart_items.sum{|cart_item|(cart_item.product.price * 1.1).floor * cart_item.quantity}
  end

  def create
    @customer = current_customer
    @cart_item = @customer.cart_items.new(cart_item_params)
    @now_cart_item = current_customer.cart_items.find_by(product_id: @cart_item.product_id)
    if @now_cart_item && @cart_item.quantity.to_i >= 1
       @now_cart_item.quantity += @cart_item.quantity
       @now_cart_item.update(quantity: @now_cart_item.quantity)
       redirect_to cart_items_path
    else
      if @cart_item.save
        redirect_to cart_items_path
      else
         flash[:alert] = "カートに入れる個数を入力してください"
         redirect_back(fallback_location: root_path)
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    @customer = Customer.find(current_customer.id)
    flash[:notice] = "カート内の商品を更新しました。"
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

   private
  def set_customer
    @customer = current_customer
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
      params.require(:cart_item).permit(:quantity, :customer_id, :product_id)
  end
end