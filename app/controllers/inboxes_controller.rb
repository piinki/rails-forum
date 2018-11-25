class InboxesController < ApplicationController
	layout "profile"
	before_action :find_inbox, only: :show

	def index
		@inboxes = current_user.inbox_recipients.includes(:creator)
	end

	def show

	end

	private

	attr_reader :inbox

	def find_inbox
		@inbox = Inbox.find_by id: params[:id]
		return if inbox

		flash[:warning] = t "inbox.messages.not_found"
		redirect_to inboxes_path
	end
end
