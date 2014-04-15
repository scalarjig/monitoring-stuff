var express = require('express');
var app = express();
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');
  
app.post('/postdata', function(req, res, next) {
    var output = "";
    
  req.on('data', function(chunk) { 
      output+=decoder.write(chunk);
  });

  req.on('end', function() {
    res.send('ok');
    doSomething(output);
  });
});

var doSomething = function(output) {
    console.log(output);
};


var server = app.listen(process.env.PORT, function() {
    console.log('Listening on port %d', server.address().port);
});



