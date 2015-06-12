function DroneControl() {
	var self = this;
	this.register = function(address, callback) {
		self[address] = callback;
		return self;
	}
}

var osc = require("node-osc");

var srv = new osc.Server(8081, "0.0.0.0");

var dc = new DroneControl();
dc.register("/test/op", function(address, data) {
	console.log(data)
});

srv.on("message", function(msg, rinfo) {
	var address = msg[0];
	var resolved = dc[address];
	resolved.call(dc, address, msg);
});