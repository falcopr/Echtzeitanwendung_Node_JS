var socket = io('http://localhost:3000/');

socket.on('connect', () => console.log("You are connected to the chat!"));

$('form').submit(function(){
  socket.emit('send_chat_message_from_client', $('#message').val());
  $('#message').val('');
  return false;
});

socket.on('receive_chat_message_from_server', function(msg){
  $('#messages').append($('<li>').text(msg));
});
