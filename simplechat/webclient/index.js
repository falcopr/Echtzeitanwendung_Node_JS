'use strict';

let express = require('express'),
    app = express(),
    http = require('http').Server(app);

app.get('/', (request, response) => response.sendFile(`${__dirname}/index.html`));

app.use(express.static(`${__dirname}/styles`));
app.use(express.static(`${__dirname}/scripts`));

let argv = require('yargs')
  .usage('Usage: $0 -port [num]')
  .alias('p', 'port')
  .default({ port: 80 })
  .argv;

let port = argv.port;
http.listen(port, () => console.log(`Listening on *:${port}`));

// http://stackoverflow.com/questions/6958780/quitting-node-js-gracefully
process.on('SIGINT', () => {
  console.log('\nGracefully shutting down from SIGINT (Ctrl-C)');
  console.log('Webserver stopped!');

  process.exit();
})
