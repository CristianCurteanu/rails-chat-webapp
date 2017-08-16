class MessageBroadcastJob < ApplicationJob
  include ActionView::Helpers::UrlHelper
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel", message:  render_message(message),
                                                 sender:   message.sender.id,
                                                 receiver: message.receiver.id
    ActionCable.server.broadcast "chat_channel", chat: render_chat(message.sender),
                                                 receiver: message.receiver.id
  end

  private

  def render_chat(sender)
    link_to sender.full_name, user_chat_path(sender.id), class: 'collection-item'
  end

  def render_message(message)
    ApplicationController.renderer.render partial: 'messages/message',
                                          locals:  {
                                            message:  message
                                          }
  end

  def user_chat_path(id)
    "/chat" "/#{id}"
  end

  def update_channel(channel_name, options = {})
    ActionCable.server.broadcast(channel_name, *options)
  end
end
