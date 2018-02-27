var fs = require("fs");
var _ = require("lodash");
var liveServer = require("live-server");
var plantuml = require('node-plantuml');
plantuml.useNailgun();

const APP_PORT = 8181;

function outputPlantumlImage(req, res, next) {
  if(_.endsWith(req.url, '.bpmn')){
    res.setHeader('Content-Type', 'application/xml');
    const name = __dirname + "/bpmn" + req.url;
    let readStream = fs.createReadStream(name);
    readStream.on('close', () => {
      res.end()
    })
    readStream.on('error', err => {
        res.statusCode = 500;
        var e = new Error(err);
        next(e);
    });
    readStream.pipe(res);
  }else if(_.endsWith(req.url, '.uml.png'))
  {
    const name = __dirname + req.url.substring(0,req.url.length-4);
    res.setHeader('Content-Type', 'image/png');
    console.log(name);
    var gen = plantuml.generate(name, {format: 'png'});
    gen.out.pipe(res);
  }else if(_.endsWith(req.url, '.uml.svg'))
  {
    const name = __dirname + req.url.substring(0,req.url.length-4);
    res.setHeader('Content-Type', 'image/svg+xml');
    console.log(name);
    var gen = plantuml.generate(name, {format: 'svg'});
    gen.out.pipe(res);
  }else{
    next();
  }
}

var params = {
    port: APP_PORT, // Set the server port. Defaults to 8080. 
    host: "0.0.0.0", // Set the address to bind to. Defaults to 0.0.0.0 or process.env.IP. 
    root: "doc", // Set root directory that's being served. Defaults to cwd. 
    open: true, // When false, it won't load your browser by default. 
    ignore: 'scss', // comma-separated string for paths to ignore 
    file: "index.html", // When set, serve this file for every 404 (useful for single-page applications) 
    wait: 1000, // Waits for all changes, before reloading. Defaults to 0 sec. 
    mount: [['/components', './node_modules']], // Mount a directory to a route. 
    logLevel: 0, // 0 = errors only, 1 = some, 2 = lots 
    htpasswd: 'htpasswd',
    middleware: [outputPlantumlImage] // Takes an array of Connect-compatible middleware that are injected into the server middleware stack 
};

console.info(`http://0.0.0.0:${APP_PORT}`);

liveServer.start(params);
