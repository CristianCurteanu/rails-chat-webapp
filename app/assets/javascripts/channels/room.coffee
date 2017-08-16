App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if @appendable(data)
      $('#messages').append data['message']

  appendable: (data) ->
    chat = $('input[type="text"]').data()
    if chat.current == data.sender
      return true
    else
      chat.other == data.sender


  speak: (message, sender, receiver) ->
    @perform 'speak', message: message, sender: sender, receiver: receiver


$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.which == 13 || event.keyCode == 13 # return/enter = send
    data = event.target.dataset
    App.room.speak event.target.value, data.current, data.other
    event.target.value = ''
    event.preventDefault()