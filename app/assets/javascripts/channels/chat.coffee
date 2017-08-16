App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if @collection().data().currentUserId == data.receiver
      audio = new Audio('/icq-message.wav')
      audio.play()
      @collection().prepend data['chat']

  collection: ->
    $('.container .collection')
