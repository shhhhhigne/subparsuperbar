var express = require('express');
var http = require('http');
const os = require('os');
var app = express();
var server = http.Server(app)
var io = require('socket.io')(server);
//var listener = 
server.listen(8888)


var lastAPICall = -1;
var manualTimer = 0;
var isRunning = false;

function currentTime() {
	// var now = new Date();
	// var time = now.getHours() + ":" + now.getMinutes() + ":" + 
	// 					now.getSeconds() + ":" + now.getMilliseconds();
	// return time;
	var here = new Date();
	var time = here.getTime();
	return time; 
}

var serverStartTime = currentTime();


function startTime(){
	var now = new Date();
	var day = now.getDay();
	var dayName = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"];
	var month = now.getMonth();
	var monthName = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];
	var date = now.getDate();
	var amPM = "am";
	var hours = now.getHours();
	if (hours>12) {
		hours = hours - 12;
		amPM = "pm";
	}
	var mins = now.getMinutes();
	if (mins<10)
		mins = "0" + mins;
	var secs = now.getSeconds();
	if (secs<10)
		secs = "0" + secs;
	var dateString = dayName[day] + ", " + monthName[month] + " " + date + "   " 
								+ hours + ":" + mins + ":" + secs + " " + amPM;
	return dateString;
}


app.get('/', function(req, res) {
	//console.log((currentTime()/1000));
	serverRunTime = (currentTime() - serverStartTime)/1000;
	apiRunTime = 0;
	if(lastAPICall == -1) {
		apiRunTime = 0;
	}
	else {
		apiRunTime = (currentTime() - lastAPICall)/1000;
	}
	
	// console.log('api run = ' + apiRunTime);
	lastAPICall = currentTime();
	var dateTime = startTime();
	var timers = JSON.stringify({'serverTimer' : serverRunTime,
					'apiTimer' : apiRunTime,
					'clock' : dateTime});
	res.setHeader('Content-Type', 'application/json');
	res.send(timers);
	//res.send(server)
	// console.log('HI!');
	// console.log('server run = ' + serverRunTime);

});

io.on('connection', function (socket) { 
	console.log('socket connection')
	socket.emit('ping', {hi: 'client'});
	socket.on('pong', function(data) {
		console.log(data);
	});
});

app.get('/check', function(req,res) {

});

app.listen(process.env.PORT || 8080);

