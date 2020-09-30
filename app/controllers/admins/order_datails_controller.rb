class Admins::OrderDatailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_item.update(order_item_params)
    if @order_item.make_status == "製作中"
       @order.update(order_status: 2)
    else
      if @order.order_items.where(make_status: 3).count == @order.order_items.count
         @order.update(order_status: 3)
      end
    end
    redirect_to admins_order_item_path(@order)
  end

  protected
  def order_item_params
    params.require(:order_item).permit(:make_status)
  end
end
