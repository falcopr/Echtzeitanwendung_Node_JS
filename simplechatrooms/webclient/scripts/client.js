let chat;
(chat = (window, manager, $, _) => {
  "use strict";

  let chatSocket = manager.connect(
        'http://localhost:3000/chat',
        {
          reconnection: true,
          reconnectionDelay: 1000
        }),
      myuserid = '';

  let appendToChatLog = (msg, userid) => {
    // Capture scroll height
    let $scrollable = $('div.messages .scrollable');
    let scrollableEl = $scrollable.get(0);
    let isScrolledToBottom =
      (scrollableEl.scrollHeight - scrollableEl.clientHeight)
      <= scrollableEl.scrollTop + 1;

    // Append message to chat protocol
    let isItMe = userid === myuserid;
    let fontweight = isItMe ? 'bold' : 'normal';
    $('#messages')
      .append($(`<li style='font-weight:${fontweight};'>`)
      .text(`${userid}: ${msg}`));
    if (isItMe) {
      $('#message').val('');
    }

    // Scroll if scrolled down
    if (isScrolledToBottom) {
      scrollableEl.scrollTop = scrollableEl.scrollHeight - scrollableEl.clientHeight;
    }
  };

  let currentRoom = '#root';
  $('#rooms').on('click', 'a', function onRoomChanging(e) {
    currentRoom = $(e.target).attr('href');
    chatSocket.emit('client:joinroom', { room: currentRoom })
  });

  $('form').on("submit", function submittedForm() {
    let msg = $('#message').val();
    chatSocket.emit('client:sendmsg', msg);
    appendToChatLog(`${msg}`, myuserid);
    return false;
  });

  let resizeWindowHandler = function() {
    let $window = $(window);
    let $messageForm = $('form.message');
    let windowHeight = $window.height();
    let messageFormHeight = $messageForm.get(0).getBoundingClientRect().height;
    $('div.messages .scrollable').height(windowHeight - messageFormHeight);
  };

  $(window).on("resize", resizeWindowHandler);
  $(resizeWindowHandler);

  chatSocket.on(
    'connect',
    function serverConnected() {
      appendToChatLog('You are connected to the chat!', 'Server');
    });

  chatSocket.on(
    'client:getuserid',
    function gotUserId(data) {
      myuserid = data.defaultSocketid;
      appendToChatLog(`You've got the client id ${myuserid}!`, 'Server');
    });

  chatSocket.on(
    'server:receivemsg',
    function receivedMsgFromServer(data) {
      appendToChatLog(`${data.msg}`, data.userid);
    });

  chatSocket.on(
    'disconnect',
    function serverDisconnected() {
      appendToChatLog('Server disconnected. Trying to reconnect...', 'Server');
    });

  chatSocket.on(
    'reconnect',
    function serverReconnected() {
      appendToChatLog('You are reconnected to the chat!', 'Server');
    });

}).call(chat, window, io, $, _);
