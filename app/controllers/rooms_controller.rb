class RoomsController < ApplicationController

  before_action do
    redirect_to root_path unless current_user
  end

  def all
    @conversations = current_user.conversations
  end

  def show
    # @messages = Message.all
    @user = User.find params[:foreign_id]
    @messages = Message.where('receiver_id in (:sender, :receiver) and sender_id in (:sender, :receiver)', sender: current_user.id, receiver: @user.id)
  end
end
