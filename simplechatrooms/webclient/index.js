'use strict';

let express = require('express'),
    app = express(),
    http = require('http').Server(app),
    fs = require('fs');

app.get('/', (request, response) => response.sendFile(`${__dirname}/index.html`));

app.use(express.static(`${__dirname}/styles`));
app.use(express.static(`${__dirname}/scripts`));

let port = 8080;
http.listen(port, () => console.log(`listening on *:${port}`));

// http://stackoverflow.com/questions/6958780/quitting-node-js-gracefully
process.on('SIGINT', () => {
  console.log('\nGracefully shutting down from SIGINT (Ctrl-C)');
  console.log('Webserver stopped!');

  process.exit();
})
