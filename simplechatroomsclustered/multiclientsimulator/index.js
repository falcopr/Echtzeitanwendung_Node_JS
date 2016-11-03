'use strict';

let io_client = require("socket.io-client");

console.log('Chat client started!\n');

let argv = require('yargs')
  .usage('Usage: $0 -port [num]')
  .alias('p', 'port')
  .default({ port: 81 })
  .argv;
let port = argv.port,
    socket = io_client.connect(
      `http://localhost:${port}/chat`,
      {
        reconnection: true,
        reconnectionDelay: 1000
      });

//http://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript
let generateUUID = () => {
  var d = new Date().getTime();
  var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = (d + Math.random()*16)%16 | 0;
      d = Math.floor(d/16);
      return (c=='x' ? r : (r&0x3|0x8)).toString(16);
  });
  return uuid;
}

let sendMailTimer;
socket.on('connect',
  function serverConnected() {
    console.log('You are connected to the chat!', 'Server');

    sendMailTimer = setInterval(() =>  {
      socket.emit('client:sendmsg', `Message: ${generateUUID()}`);
      console.log(`Ich: ${generateUUID()}`);
    }, 10000);
  });

socket.on('disconnect',
  function serverDisconnected() {
    console.log('Server disconnected. Trying to reconnect...');

    if (sendMailTimer) {
      clearInterval(sendMailTimer);
    }
  });

socket.on('reconnect',
  function serverReconnected() {
    console.log('You are reconnected to the chat!');

    sendMailTimer = setInterval(() =>  {
      socket.emit('client:sendmsg', `Message: ${generateUUID()}`);
      console.log(`Me: ${generateUUID()}`);
    }, 10000);
  });

socket.on('server:receivemsg', data => console.log(`\nYou: ${data.msg}`));

// http://stackoverflow.com/questions/6958780/quitting-node-js-gracefully
process.on('SIGINT', () => {
  console.log('\nGracefully shutting down from SIGINT (Ctrl-C)');
  console.log('Client stopped!');

  process.exit();
})
