'use strict';



// http://socket.io/docs/
let port = 3000,
    Server = require('socket.io'),
    io = new Server(port),
    _ = require('lodash');


console.log('Server started!');
console.log(`listening on *:${port}`);

io.on('connection', socket => {
  console.log('A client connected');

  socket.on('send_chat_message_from_client', msg => {
     console.log(`message: ${msg}`);

     //io.emit('receive_chat_message_from_server', msg);
     socket.broadcast.emit('receive_chat_message_from_server', msg);
  });

  socket.on('disconnect', () => console.log('A client disconnected'));
});

// http://stackoverflow.com/questions/6958780/quitting-node-js-gracefully
process.on('SIGINT', () => {
  console.log('Gracefully shutting down from SIGINT (Ctrl-C)');
  console.log('Server stopped!');

  process.exit();
})
