'use strict';

console.log('Server started!');

// http://socket.io/docs/
let port = 3000;
let Server = require('socket.io');
let io = new Server(port);
console.log(`listening on *:${port}`);

io.on(
  'connection',
  function clientConnected(socket) {
    console.log(`The client ${socket.id} connected`);
    socket.emit('client:getuserid', { socketid: socket.id });

    socket.broadcast.emit(
      'server:receivemsg',
      {
        userid: 'Server',
        msg: `Client ${socket.id} joined the chat.`
      });

    socket.on(
      'client:sendmsg',
      function receivedClientMsg(msg) {
        console.log(`${socket.id}: ${msg}`);
        socket.broadcast.emit('server:receivemsg', { msg: msg, userid: socket.id });
      });

    socket.on(
      'disconnect',
      function clientDisconnected() {
        console.log(`The client ${socket.id} disconnected`);
        socket.broadcast.emit(
          'server:receivemsg',
          {
            userid: 'Server',
            msg: `Client ${socket.id} left the chat.`
          });
      });
  });

// http://stackoverflow.com/questions/6958780/quitting-node-js-gracefully
process.on('SIGINT', () => {
  console.log('Gracefully shutting down from SIGINT (Ctrl-C)');
  console.log('Server stopped!');

  process.exit();
})
