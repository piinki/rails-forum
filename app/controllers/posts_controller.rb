class PostsController < ApplicationController
  before_action :find_topic, only: %i(create)
  before_action :find_post, only: %i(edit update destroy upvote downvote)

  def create
    authorize Post
    @post = @topic.posts.build post_params
    post.user = current_user
    if post.save
      flash[:success] = t "post.messages.create_success"
      redirect_to topic_path(post.topic, anchor: "post-bookmark-#{post.id}")
    else
      flash[:warning] = t "post.messages.create_fail"
      render :edit
    end
  end

  def edit
    authorize post
  end

  def update
    authorize post
    if post.update_attributes post_params.merge editor_id: current_user.id
      flash[:success] = t "post.messages.update_success"
      redirect_to topic_path(post.topic, anchor: "post-bookmark-#{post.id}")
    else
      flash[:warning] = t "post.messages.update_fail"
      render :edit
    end
  end

  def destroy
    authorize post
    if post.destroy
      flash[:success] = t "post.messages.delete_success"
    else
      flash[:warning] = t "post.messages.delete_fail"
    end
    redirect_to topic_path(post.topic)
  end

  def restore
    post = Post.with_deleted.find_by id: params[:id]
    authorize post
    if post.restore
      flash[:success] = t "post.messages.restore_success"
    else
      flash[:warning] = t "post.messages.restore_fail"
    end
    redirect_to topic_path(post.topic)
  end

  def upvote
    vote = post.votes.find_by user_id: current_user.id
    if vote
      return if vote.up_vote_type?
      vote.destroy
    else
      post.votes.create vote_type: :up, user: current_user
    end
  end

  def downvote
    vote = post.votes.find_by user_id: current_user.id
    if vote
      return if vote.down_vote_type?
      vote.destroy
    else
      post.votes.create vote_type: :down, user: current_user
    end
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
