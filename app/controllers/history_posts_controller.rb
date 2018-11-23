class HistoryPostsController < ApplicationController
  before_action :find_post, only: %i(index)

  def index
    @histories = post.versions
  end

  private

  attr_reader :post

  def find_post
    @post = Post.find_by id: params[:post_id]
    return if post

    flash[:warning] = "Cannot found post"
    redirect_to root_path
  end
end
