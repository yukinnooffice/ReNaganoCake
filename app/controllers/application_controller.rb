class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_host
  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :zipcode, :address, :tel])
  end

# ログアウト後遷移
  def after_sign_out_path_for(resource)
	if resource == :admin
		new_admin_session_path
	else
		root_path
	end
end
	
	# ログイン後遷移
  def after_sign_in_path_for(resource)
  	if resource.instance_of?(Admin)
  		admins_home_path
  	else
  		root_path
  	end
  end

# sessions_newカスタマーのエラー文です　反映されていません　たぶんsessionsコントローラーいります。
   def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @customer
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == true))
        flash[:error] = "退会済みです。"
        redirect_to new_customer_session_path
      end
    else
      flash[:error] = "必須項目を入力してください。"
    end
  end

end
