class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:product)
    @total_price = @order_items.sum{|order_item|(order_item.order_price * 1.1).floor * order_item.quantity  }
  end

  def new
    @customer = current_customer
    @order = Order.new
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
      current_customer.cart_items.each do |cart_item|
        @order_item = @order.order_items.new
        @order_item.order_id = @order.id
        @order_item.product_id = cart_item.product_id
        @order_item.quantity = cart_item.quantity
        @order_item.order_price = cart_item.product.price
        @order_item.save
      end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def index
    @orders = current_customer.orders.includes(order_items: :product)
  end

  def comfirm
    @customer = current_customer
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    # 自身の住所
    if params[:order][:select_address] == "customer_address"
      @order.zipcode = @customer.zipcode
      @order.send_to_address = @customer.address
      @order.addressee = @customer.last_name + @customer.first_name
    # 登録済住所
    elsif params[:order][:select_address] == "deliverey_address"
      @address = Address.find(params[:select_delivery][:id])
      @order.zipcode = @address.zipcode
      @order.send_to_address = @address.address
      @order.addressee = @address.ship_name
    # 新しいお届け先
    elsif params[:order][:select_address] == "new_deliverey_address"
      @address = Address.new
      @address.zipcode = params[:order][:new_zipcode]
      @address.address = params[:order][:new_address]
      @address.ship_name = params[:order][:new_name]
      @address.customer_id = current_customer.id
      if @address.save
        @order.zipcode = @address.zipcode
        @order.send_to_address = @address.address
        @order.addressee = @address.ship_name
      else
        render "new"
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :freight, :total_price, :how_to_pay,
     :zipcode, :send_to_address, :addressee, :order_status, order_items_attributes:
      [:order_id, :product_id, :quantity, :order_price, :make_status])
  end

end