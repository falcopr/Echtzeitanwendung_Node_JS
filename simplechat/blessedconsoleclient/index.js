"use strict"

let blessed = require("blessed"),
    io_client = require("socket.io-client");

let screen = blessed.screen({
  smartCSR: true,
  fullUnicode: true
});

screen.title = 'My blessed chat client.'

// let socket = io_client.connect('http://localhost:3000');

//socket.on('receive_chat_message_from_server', msg => console.log(`\nAndere: ${msg}`));

var box = blessed.box({
  parent: screen,
  bottom: 1,
  left: 'center',
  width: '100%',
  height: 5,
  tags: true,
  border: {
    type: 'line'
  },
  style: {
    fg: 'white',
    bg: 'magenta',
    border: {
      fg: '#f0f0f0'
    }
  }
});

var box = blessed.textbox({
  parent: box,
  // Possibly support:
  // align: 'center',
  style: {
    bg: 'blue'
  },
  height: 1,
  width: '98%',
  bottom: 1,
  left: 'center',
  tags: true
});

screen.render();

screen.key('q', () => {
  screen.destroy();
});

screen.key('i', () => {
  box.readInput(function() {});
});

screen.key('e', () => {
  box.readEditor(function() {});
});

// http://stackoverflow.com/questions/6958780/quitting-node-js-gracefully
process.on('SIGINT', () => {
  console.log('\nGracefully shutting down from SIGINT (Ctrl-C)');
  console.log('Client stopped!');

  reader.close();
  process.exit();
})
