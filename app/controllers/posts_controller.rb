class PostsController < ApplicationController
  def create
    @topic = Topic.find_by id: params[:topic_id]
    @post = @topic.posts.build post_params
    post.user = current_user
    # binding.pry
    if post.save
      flash[:success] = "Create topic successfully"
      redirect_to topic_path(post.topic)
    else
      flash[:warning] = "Cannot create topic"
      render :new
    end
  end

  private

  attr_reader :post

  def post_params
    params.require(:post).permit :content, :topic_id
  end
end
