class ListsController < ApplicationController

  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @bookmarks = Bookmark.all
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
      render 'new'
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

end
