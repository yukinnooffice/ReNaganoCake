class Admins::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders.quantity_total.page(params[:page]).reverse_order
    elsif params[:created_at]
      @orders = Order.where("DATE(created_at) = '#{Date.current}'").page(params[:page]).reverse_order
    else
      @orders = Order.quantity_total.page(params[:page]).reverse_order
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:product)
    @total_price = @order_items.sum{|order_item|(order_item.order_price * 1.1).floor * order_item.quantity }
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order.update(order_params)
    if @order.order_status == "入金待ち"
       @order_items.update_all(make_status: 0)
    elsif @order.order_status == "入金確認"
      @order_items.update_all(make_status: 1)
    end
    redirect_to admins_order_item_path(@order)
  end

  protected
  def order_params
    params.require(:order).permit(:order_status)
  end

end