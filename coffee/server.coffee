app = require('express')()
server = require('http').createServer app
io = require('socket.io').listen server
exec = require('child_process').exec;

server.listen 8083

app.get '/', (req, res)->
	res.sendfile __dirname + '/html/index.html'


x = 0
y = 0

direction = "no"
setInterval ->
	console.log 'direction', direction
	if direction is "no" then return no

	if direction is "up" then x = x - 1
	if direction is "down" then x = x + 1
	if direction is "left" then y = y - 1
	if direction is "right" then y = y + 1
	exec "xdotool mousemove #{y} #{x}", (error, stdout, stderr)->
		console.log stdout

	, 500

io.sockets.on 'connection', (socket)->

	child = exec 'xdotool getmouselocation', (error, stdout, stderr)->
		console.log stdout



	socket.on 'movemouse', (new_direction)->
		direction = new_direction
		console.log 'new direction'