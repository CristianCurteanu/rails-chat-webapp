class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel",
                                  message:  render_message(message),
                                  sender:   message.sender.id,
                                  receiver: message.receiver.id
  end

  private

  def render_message(message)
    ApplicationController.renderer.render partial: 'messages/message',
                                          locals:  {
                                            message:  message
                                          }
  end
end
