class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user

    # logger.debug current_user.id

    if @bookmark.save
      flash[:notice] = "Your new bookmark was saved."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Your bookmark was updated."
      redirect_to topics_path
    else
      flash.now[:alert] = "There was an error saving the bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
       flash[:notice] = "\"#{@bookmark}\" was successfully deleted."
       redirect_to topics_path
     else
       flash.now[:alert] = "There was an error deleting the bookmark."
       render :show
     end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
