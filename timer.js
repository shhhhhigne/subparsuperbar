var express = require('express');
var app = express();
const os = require('os');

var serverStartTime = os.uptime();
var lastAPICall = -1;

app.get('/', function(req, res) {
	serverRunTime = os.uptime() - serverStartTime;
	if(lastAPICall == -1) {
		apiRunTime = 0;
	}
	else {
		apiRunTime = os.uptime() - lastAPICall;
	}
	console.log('api run = ' + apiRunTime);
	lastAPICall = os.uptime();
	console.log('HI!');
	console.log('server run = ' + serverRunTime);

});

app.get('/check', function(req,res) {

});

app.listen(process.env.PORT || 8080);