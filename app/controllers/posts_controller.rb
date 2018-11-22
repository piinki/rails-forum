class PostsController < ApplicationController
  before_action :find_topic, only: %i(create)
  before_action :find_post, only: %i(edit update destroy)

  def create
    authorize Post
    @post = @topic.posts.build post_params
    post.user = current_user
    if post.save
      flash[:success] = t "post.messages.create_successful"
      redirect_to topic_path(post.topic, anchor: "post-bookmark-#{post.id}")
    else
      flash[:warning] = t "post.messages.create_fail"
      render :edit
    end
  end

  def edit; end

  def update
    if post.update_attributes post_params.merge editor_id: current_user.id
      flash[:success] = t "post.messages.update_successful"
      redirect_to topic_path(post.topic, anchor: "post-bookmark-#{post.id}")
    else
      flash[:warning] = t "post.messages.update_fail"
      render :edit
    end
  end

  def destroy
    if post.destroy
      flash[:success] = t "post.messages.delete_successful"
    else
      flash[:warning] = t "post.messages.delete_fails"
    end
    redirect_to topic_path(post.topic)
  end

  private

  attr_reader :post, :topic

  def find_topic
    @topic = Topic.find_by id: params[:topic_id]
    return if topic

    flash[:warning] = t "messages.not_found_topic"
    redirect_to topics_path
  end

  def find_post
    @post = Post.find_by id: params[:id]
    return if post

    flash[:warning] = t "messages.not_found_post"
    redirect_to topics_path
  end

  def post_params
    params.require(:post).permit :content, :topic_id
  end
end
