class Admins::ProductsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @product = Product.new
    @genres = Genre.where(genre_status: "true" )
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @products = @genre.products.page(params[:page])
    else
      @products = Product.page(params[:page]).includes(:genre)
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "商品を登録しました。"
      redirect_to admins_product_path(@product)
    else
      render :new
    end
  end

  def edit
    @product =Product.find(params[:id])
    @genres = Genre.where(genre_status: "true" )
  end

  def update
    @product =Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admins_products_path
      flash[:notice] = "商品を更新しました。"
    else
      render :edit
    end
  end

  def search
    @model = params[:model]
    if @model == "customer"
      @customers = Customer.search(params[:search], @model)
    else
      @products = Product.search(params[:search], @model).includes(:genre)
    end
  end

  protected

  def product_params
    params.require(:product).permit(:name, :introduction, :image, :price, :status, :genre_id, :genre_name)
  end
end
