class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(index show)
  before_action :find_topic, only: %i(show edit update destroy pin unpin toggle_lock)
  before_action :check_permision_category, only: :create

  def index
    @topics = policy_scope(Topic).includes(:category).page(params[:page]).per Settings.per_page.topic
  end

  def new
    authorize Topic
    @topic = Topic.new
    topic.posts.build
    @categories = CategoryPolicy::Scope.new(current_user, Category).categories
  end

  def create
    authorize Topic
    @topic = Topic.new topic_params
    topic.creator = current_user
    if topic.save
      flash[:success] = t "topic.messages.create_success"
      redirect_to topic_path(topic)
    else
      @categories = Category.all
      flash[:warning] = t "topic.messages.create_fail"
      render :new
    end
  end

  def edit
    authorize topic
    @categories = Category.all
  end

  def update
    authorize topic
    if topic.update_attributes topic_params.merge editor_id: current_user.id
      flash[:success] = t "topic.messages.update_success"
      redirect_to topic_path(topic)
    else
      @categories = Category.all
      flash[:warning] = t "topic.messages.update_fail"
      render :edit
    end
  end

  def destroy
    authorize topic
    if topic.destroy
      sent_inbox
      flash[:success] = t "topic.messages.delete_success"
      redirect_to category_path(topic.category)
    else
      flash[:warning] = t "topic.messages.delete_fail"
      redirect_to topic_path(topic)
    end
  end

  def pin
    authorize topic
    if topic.update_attributes pin_at: Time.current
      flash[:success] = t "topic.messages.pin_success"
    else
      error ||= topic.errors.full_messages
      flash[:warning] = t "topic.messages.pin_fail", error: error.join('. ')
    end
    redirect_to topic_path(topic)
  end

  def unpin
    authorize topic
    if topic.update_attributes pin_at: nil
      flash[:success] = t "topic.messages.unpin_success"
    else
      flash[:warning] = t "topic.messages.unpin_fail"
    end
    redirect_to topic_path(topic)
  end

  def toggle_lock
    authorize topic
    locked = topic.locked_at ?  nil : Time.current
    if topic.update_attributes locked_at: locked
      flash[:success] = t "topic.messages.update_status_success"
    else
      flash[:warning] = t "topic.messages.update_status_fail"
    end
    redirect_to topic_path(topic)
  end


  def show
    increase_view
  end

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

  def sent_inbox
    return if current_user == topic.creator
    content = t "inbox.template.delete_post", link: topic_path(topic),
      pic: current_user.full_name, title: topic.title
    inbox = current_user.inboxes.create content: content,
      title: t('inbox.template.delete_title', id: topic.id), recipient_id: topic.creator.id
  end

  def increase_view
    return unless current_user
    viewer = topic.views.find_by user_id: current_user.id, ip_address: request.remote_ip
    return if viewer
    topic.views.create user_id: current_user.id, ip_address: request.remote_ip
  end

  def check_permision_category
    category = Category.find_by id: params[:topic][:category_id]
    return if category.published?

    flash[:warning] = "You don't permision with category"
    redirect_to topics_path
  end
end
