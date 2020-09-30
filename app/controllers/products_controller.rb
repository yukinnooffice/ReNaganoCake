class ProductsController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :top, :about, :show, :search]
  
   def index
    @genres = Genre.where(genre_status: "true" )
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @products = @genre.products.all
    else
      @products = Product.joins(:genre).where("genres.genre_status = ?", true )
    end
  end

  def show
    @genres = Genre.where(genre_status: "true" )
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @products = @genre.products.all.includes(:genre)
    else
      @products = Product.joins(:genre).where("genres.genre_status = ?", true )
    end
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end

  def about
  end

  def top
    @genres = Genre.where(genre_status: "true" )
    @recommendation = Product.where(status: "true" ).joins(:genre).where("genres.genre_status = ?", true ).limit(4).order(created_at: :desc)
  end

   def search
    @model = "product"
    @products = Product.joins(:genre).where("genres.genre_status = ?", true ).search(params[:search], @model)
  end

  private
    def product_params
      params.require(:product).permit(:genre_id, :name, :introduction, :image, :price, :status)
    end
end
