class CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer.id), notice: "登録情報を編集しました"
    else
       flash[:warning] = "入力内容が間違ってるよ"
       render :edit
    end
  end

  def show
    @customer = Customer.find(params[:id])

  end

  def withdraw

  end

  def usubscribe
      @customer = Customer.find(current_customer.id)
      if @customer.update!(customer_status: false)
         sign_out current_customer
      end
      redirect_to root_path
  end


  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :zipcode, :address, :tel)
  end
end
