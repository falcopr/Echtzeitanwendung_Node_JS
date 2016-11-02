'use strict';

console.log('Server started!');

let port = 3000,
    Server = require('socket.io'),
    io = new Server(port);
console.log(`Listening on *:${port}`);

io.on(
  'connect',
  function clientConnected(socket) {
    console.log(`The client ${socket.id} connected`);
    socket.emit('client:getuserid', { socketid: socket.id });

    socket.broadcast.emit('server:receivemsg',
      {
        userid: 'Server',
        msg: `Client ${socket.id} joined the chat.`
      });

    socket.on('client:sendmsg',
      function receivedClientMsg(msg) {
        console.log(`${socket.id}: ${msg}`);
        socket.broadcast.emit('server:receivemsg', { msg: msg, userid: socket.id });
      });

    socket.on('disconnect',
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
