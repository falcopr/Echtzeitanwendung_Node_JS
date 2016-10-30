'use strict';

let rl = require("readline"),
    io_client = require("socket.io-client");

let reader = rl.createInterface({
  input: process.stdin,
  output: process.stdout
});

console.log('Chat client started!\n');

let socket = io_client.connect('http://127.0.0.1:3000');

socket.on('receive_chat_message_from_server', msg => console.log(`\nAndere: ${msg}`));

// Message
let questionRecursively = function() {
  reader.question('Ich: ', msg => {
    socket.emit('send_chat_message_from_client', msg);
    questionRecursively();
  });
};

questionRecursively();

// http://stackoverflow.com/questions/6958780/quitting-node-js-gracefully
process.on('SIGINT', () => {
  console.log('\nGracefully shutting down from SIGINT (Ctrl-C)');
  console.log('Client stopped!');

  reader.close();
  process.exit();
})
