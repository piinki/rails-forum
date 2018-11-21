module ApplicationHelper
  def full_title page_title = ""
    base_title = t "app_name"
    return base_title if page_title.empty?
    page_title + " | " + base_title
  end

  def store_location
    session[:forwarding_url] = request.referer if request.get?
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end
end
