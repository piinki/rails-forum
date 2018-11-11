class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(index show)
  before_action :find_topic, only: %i(show edit update destroy pin unpin)

  def index
    @topics = Topic.all.page(params[:page]).per Settings.per_page.topic
  end

  def new
    @topic = Topic.new
    topic.posts.build
    @categories = Category.all
  end

  def create
    @topic = Topic.new topic_params
    topic.creator = current_user
    if topic.save
      flash[:success] = t "topic.messages.create_successful"
      redirect_to topic_path(topic)
    else
      @categories = Category.all
      flash[:warning] = t "topic.messages.create_fail"
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @topic.update_attributes topic_params
      flash[:success] = t "topic.messages.update_successful"
      redirect_to topic_path(topic)
    else
      @categories = Category.all
      flash[:warning] = t "topic.messages.update_fail"
      render :edit
    end
  end

  def destroy
    authorize Topic
    if topic.destroy
      flash[:success] = t "topic.messages.delete_successful"
      redirect_to category_path(topic.category)
    else
      flash[:warning] = t "topic.messages.delete_fail"
      redirect_to topic_path(topic)
    end
  end

  def pin
    if topic.update_attributes pin_at: Time.current
      flash[:success] = "Bai viet da ghim"
    else
      flash[:warning] = "Bai viet khong the ghim"
    end
    redirect_to topic_path(topic)
  end

  def unpin
    if topic.update_attributes pin_at: nil
      flash[:success] = "Bai viet da bo ghim"
    else
      flash[:warning] = "Bai viet khong the bo ghim"
    end
    redirect_to topic_path(topic)
  end


  def show; end

  private

  attr_reader :topic

  def find_topic
    @topic = Topic.find_by id: params[:id]
    return if topic

    flash[:warning] = t "messages.not_found_topic"
    redirect_to topics_path
  end

  def topic_params
    params.require(:topic).permit :title, :category_id, :pin_at, posts_attributes: [:id, :content]
  end
end
