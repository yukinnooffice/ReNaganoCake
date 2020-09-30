class Admins::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admins_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    flash[:notice] = "ジャンルを更新しました。"
    redirect_to admins_genres_path
  end

  protected
    def genre_params
      params.require(:genre).permit(:genre_name, :genre_status)
    end
end
