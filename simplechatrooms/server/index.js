'use strict';

console.log('Server started!');

let port = 3000,
    Server = require('socket.io'),
    io = new Server(port),
    chatNamespace = io.of('/chat');
console.log(`Listening on *:${port}`);

chatNamespace.on(
  'connect',
  function clientConnected(socket) {
    let currentRoomName = '#root';
    socket.join(currentRoomName);

    console.log(`The client ${socket.id} connected and joined room ${currentRoomName}`);
    socket.emit('client:getuserid', { socketid: socket.id });

    socket.broadcast.to(currentRoomName).emit(
      'server:receivemsg',
      {
        userid: 'Server',
        msg: `Client ${socket.id} joined the chat in room ${currentRoomName}.`
      });

    socket.on(
      'client:sendmsg',
      function receivedClientMsg(msg) {
        console.log(`${socket.id}: ${msg}`);
        socket.broadcast.to(currentRoomName).emit('server:receivemsg', { msg: msg, userid: socket.id });
      });

    socket.on(
      'client:joinroom',
      function requestRoomJoining(data) {
        console.log(`${socket.id}: Leaving room ${currentRoomName}`);
        socket.emit(
          'server:receivemsg',
          {
            userid: 'Server',
            msg: `You left the room ${currentRoomName}.`
          });
        socket.broadcast.to(currentRoomName).emit(
          'server:receivemsg',
          {
            userid: 'Server',
            msg: `Client ${socket.id} left the room ${currentRoomName}.`
          });
        socket.leave(currentRoomName);

        currentRoomName = data.room;
        console.log(`${socket.id}: Joining room ${currentRoomName}`);
        socket.join(currentRoomName);
        socket.emit(
          'server:receivemsg',
          {
            userid: 'Server',
            msg: `You joined the room ${currentRoomName}.`
          });
        socket.broadcast.to(currentRoomName).emit(
          'server:receivemsg',
          {
            userid: 'Server',
            msg: `Client ${socket.id} joined the room ${currentRoomName}.`
          });
      });

    socket.on(
      'disconnect',
      function clientDisconnected() {
        console.log(`The client ${socket.id} disconnected`);
        socket.broadcast.to(currentRoomName).emit(
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
