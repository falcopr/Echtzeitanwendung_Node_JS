'use strict';

(function() {
  var socket = io('http://localhost:3000/');
  var currentRoom = '#root';

  socket.on('connect', function() { console.log("You are connected to the chat!") });

  $('form').submit(function(){
    var msg = $('#message').val();
    socket.emit('send_chat_message_from_client', msg);
    $('#messages').append($('<li>').text('Ich: ' + msg));
    $('#message').val('');
    return false;
  });

  $('#rooms').on('click', 'a', function onclickHandler(e) {
    socket.leave(currentRoom);
    currentRoom = $(e.target).attr('href');
    socket.emit('join_room', { room: currentRoom })
  });

  socket.join(currentRoom);

  socket.on('receive_chat_message_from_server', function(msg){
    $('#messages').append($('<li>').text('Anderer:' + msg));
  });
})();
