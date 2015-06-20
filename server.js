var fs   = require('fs');
var path = require('path');
var Hapi = require('hapi');

var CONFIG = {
  port:    process.env['PORT'],
  version: process.env['CLIENT_VERSION']
};

console.log("[http] Starting bootstrap server");

if (!CONFIG.version) {
  console.log("[http] ERROR: No client version specified, bootstrap server cannot start");
  process.exit(1);
}

var shim = fs.readFileSync(path.resolve(__dirname, 'assets/index.html'), 'utf8')
shim = shim.replace(/%VERSION%/g, CONFIG.version)

var server = new Hapi.Server();
server.connection({port: CONFIG.port});

server.route({
  method: '*',
  path:   '/{path*}',
  handler: function(req, reply) {
    if (request.server.info.protocol !== 'https' && request.headers['x-forwarded-proto'] !== 'https')
      reply.redirect("https://" + request.headers.host + request.path);
    else
      reply(shim);
  }
});

server.start(function() {
  console.log("[http] Bootstrap server started, serving client version " + CONFIG.version);
});