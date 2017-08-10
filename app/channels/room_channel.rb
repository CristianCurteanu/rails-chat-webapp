class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    sender, receiver = User.find(data['sender']), User.find(data['receiver'])
    Message.create! sender: sender, receiver: receiver, content: data['message']
  end
end
