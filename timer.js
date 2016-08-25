var express = require('express');
var app = express();
const os = require('os');

var serverStartTime = os.uptime();

app.get('/', function(req, res) {
	serverRunTime = os.uptime() - serverStartTime;
	console.log('HI!');
	console.log(serverRunTime);
});

app.get('/check', function(req,res) {

});

app.listen(process.env.PORT || 8080);