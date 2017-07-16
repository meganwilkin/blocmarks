class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new
    @topic.title = params[:topic][:title]
    @topic.user = current_user

    if @topic.save
      flash[:alert] = "Your new topic was saved"
      redirect_to @topic
    else
      flash.now[:alert] = "An error occured saving the topic.  Please try again."
      render :new
    end
  end

  # def edit
  #   @topic = Topic.find(params[:id])
  # end
  #
  # def update
  #   @topic = Topic.find(params[:id])
  #   @topic.title = params[:topic][:title]
  #
  #   if @topic.save
  #     flash[:alert] = "Topic was updated"
  #     redirect_to @topic
  #   else
  #     flash.now[:alert] = "An error occured updating the topic.  Please try again."
  #     render :edit
  #   end
  # end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
       flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
       redirect_to topics_path
     else
       flash.now[:alert] = "There was an error deleting the topic."
       render :show
     end
  end

end