class Managers::InboxesController < Managers::BaseController
  def index; end

  def new
    @inbox = Inbox.new
  end
end
