class BookmarksController < ApplicationController

  def show
    @bookmark = Bookmark.find_by(id: params[:id])

    if @bookmark
      @list = @bookmark.list
    else
      flash[:alert] = 'Bookmark not found.'
      redirect_to lists_path
    end
  end


  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @movies = Movie.all
    @url = "https://image.tmdb.org/t/p/w500"
  end

def create
  @list = List.find(params[:list_id])
  @bookmark = Bookmark.new(bookmark_params)
  @bookmark.list = @list
  if @bookmark.save
    redirect_to list_path(@list)
  else
    @movies = Movie.all
    render :new, status: :unprocessable_entity
  end
end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), statuts: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end

end
