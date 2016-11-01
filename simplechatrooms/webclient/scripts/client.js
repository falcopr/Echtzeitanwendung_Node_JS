let chat;
(chat = (manager, $, _) => {
  "use strict";

  let socket = manager.connect(
        'http://localhost:3000/',
        {
          reconnection: true,
          reconnectionDelay: 1000
        }),
      myuserid = '';

  let appendToChatLog = (msg, userid) => {
    let isItMe = userid === myuserid;
    let fontweight = isItMe ? 'bold' : 'normal';
    $('#messages')
      .append($(`<li style='font-weight:${fontweight};'>`)
      .text(`${userid}: ${msg}`));
    if (isItMe) {
      $('#message').val('');
    }
  };

  // var currentRoom = '#root';
  // $('#rooms').on('click', 'a', function onclickHandler(e) {
  //   socket.leave(currentRoom);
  //   currentRoom = $(e.target).attr('href');
  //   socket.emit('join_room', { room: currentRoom })
  // });

  socket.on(
    'connect',
    function serverConnected() {
      appendToChatLog('You are connected to the chat!', 'Server');
    });

  socket.on(
    'client:getuserid',
    function gotUserId(data) {
      myuserid = data.socketid;
      appendToChatLog(`You've got the client id ${myuserid}!`, 'Server');
    });

  $('form').submit(function submittedForm() {
    var msg = $('#message').val();
    socket.emit('client:sendmsg', msg);
    appendToChatLog(`${msg}`, myuserid);
    return false;
  });

  socket.on(
    'server:receivemsg',
    function receivedMsgFromServer(data) {
      appendToChatLog(`${data.msg}`, data.userid);
    });

  socket.on(
    'disconnect',
    function serverDisconnected() {
      appendToChatLog('Server disconnected. Trying to reconnect...', 'Server');
    });

  socket.on(
    'reconnect',
    function serverReconnected() {
      appendToChatLog('You are reconnected to the chat!', 'Server');
    });

}).call(chat, io, $, _);
