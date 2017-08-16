class RoomsController < ApplicationController
  before_action :authorize

  before_action do
    redirect_to root_path unless current_user
  end

  def all
    @conversations = current_user.conversations
  end

  def show
    @user = User.find params[:foreign_id]
    @messages = current_user.messages_with @user
  end
end
