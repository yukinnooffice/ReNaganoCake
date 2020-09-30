Rails.application.routes.draw do
   devise_for :customers

   devise_for :admins, controllers: {
    sessions:      'admins/devise/sessions',
    passwords:     'admins/devise/passwords',
    registrations: 'admins/devise/registrations'
  }
 #↑controllersでカスタマー側とURLを分けてます。

 # customer側ルーティング
  root "products#top"
  get "products/about" => "products#about", as: 'products_about'
  patch "customers/usubscribe" => "customers#usubscribe", as: 'customers_usubscribe'
  get "customers/withdraw" => "customers#withdraw", as: 'customers_withdraw'
  resources :products, only: [:index, :show]
  resources :customers, only: [:edit ,:update, :show]
  resources :cart_items, only: [:index, :create, :update, :destroy] do
    collection do
        delete 'destroy_all'
    end
  end
  get "orders/thanks" => "orders#thanks", as: 'orders_thanks'
  post 'orders/comfirm' => 'orders#comfirm', as: 'order_comfirm'
  get "orders/comfirm" => "orders#comfirm", as: 'orders_comfirm'
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :orders, only:[:show, :new, :create, :index]
  get "search" => "products#search", as:"customers_search"
  # admin側ルーティング
  namespace :admins do
    root "devise#new"
    get "top" => "homes#top", as: 'home'
    resources :products, only: [:new, :show, :index, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :order_datails, only: [:update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :order_items, only: [:index, :show, :update]
    get "search" => "products#search", as:"search"
  end
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end