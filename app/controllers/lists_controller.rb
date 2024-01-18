class ListsController < ApplicationController

  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @bookmarks = Bookmark.all
    @url = "https://image.tmdb.org/t/p/w500"
  end

  def new
    @list = List.new
  end

  def create
    # raise
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      # render :new
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to root_path, status: :see_other, notice: 'List was successfully destroyed.'
  end


  private

  def list_params
    params.require(:list).permit(:name)
  end

end
