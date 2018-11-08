class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(index show)
  before_action :find_topic, only: %i(show edit update destroy)

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    topic.posts.build
    @categories = Category.all
  end

  def create
    @topic = Topic.new topic_params
    topic.creator = current_user
    topic.posts.first.user = current_user
    if topic.save
      flash[:success] = "Create topic successfully"
      redirect_to topic_path(topic)
    else
      @categories = Category.all
      flash[:warning] = "Cannot create topic"
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    # binding.pry
    if @topic.update_attributes topic_params
      flash[:success] = "Edit topic successfully"
      redirect_to topic_path(topic)
    else
      @categories = Category.all
      flash[:warning] = "Cannot edit topic"
      render :edit
    end
  end


  def show

  end

  private

  attr_reader :topic

  def find_topic
    @topic = Topic.find_by id: params[:id]
    return if topic

    flash[:warning] = "Cannot find topic"
    redirect_to topics_path
  end

  def topic_params
    params.require(:topic).permit :title, :category_id, posts_attributes: [:id, :content]
  end
end
