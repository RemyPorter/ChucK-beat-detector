var osc = require("node-osc");
var ard = require("ar-drone");
var parseArgs = require("minimist");

var port = 8081;
var sources = "0.0.0.0";
var id = 0;

var argv = parseArgs(process.argv);

if (argv.port) port = argv.port;
if (argv.mask) sources = argv.mask;
if (argv.id) id = argv.id;

console.log("Launching OSC server on " + port +
	", listening to addresses like " + sources);


function DroneControl() {
	var self = this;
	this.flying = false;
	self.drone = ard.createClient();
	self.drone.config("control:altitude_max", 5000);
	this.register = function(address, callback) {
		self[address] = function(address, data) {
			var sliced = data.slice(1);
			callback(self.drone, address, sliced);
		}
		return self;
	}
	self.drone.on("navdata", function(data) {
		self.navdata = data;
	});
}

function path(id, path) {
	return "/drone/ID" + id + path;
}

function parsePath(path) {
	var split = path.split("/");
	return {
		id: split[2],
		message: "/" + split.slice(3)
	}
}

var srv = new osc.Server(port, sources);


var dc = new DroneControl();
dc.register(path(id, "/test/op"), function(drone, address, data) {
	console.log(data);
})
.register(path(id, "/takeoff"), function(drone, address, data) {
	drone.takeoff(function() {
		dc.flying = true;
		dc.zero = dc.navdata;
	});
})
.register(path(id, "/zero"), function(drone, address, data) {
	dc.zero = dc.navdata;
})
.register(path(id, "/land"), function(drone, address, data) {
	drone.stop();
	drone.land(function() {
		dc.flying = false;
	});
})
.register(path(id, "/move/stop"), function(drone, address, data) {
	drone.stop();
})
.register(path(id, "/config/outdoor"), function(drone, address, data) {
	drone.config("CONFIG:outdoor", data[0]);
})
.register(path(id, "/config/vert_speed"), function(drone, address, data) {
	drone.config("CONTROL:control_vz_max", data[0]);
})
.register(path(id, "/config/yaw_speed"), function(drone, address, data) {
	drone.config("CONTROL:control_yaw", data[0]);
})
.register(path(id, "/config/no_shell"), function(drone, address, data) {
	drone.config("CONTROL:flight_without_shell", data[0]);
})
.register(path(id, "/reset"), function(drone, address, data) {
	drone.disableEmergency();
	drone.stop();
})
;

["left", "right", 
	"up", "down", 
	"clockwise", "counterClockwise",
	"front", "back"].forEach(function(direction) {
		dc.register(path(id, "/move/")+direction, function(drone, address, data) {
			drone[direction](data[0]);
		});
	});
['phiM30Deg', 'phi30Deg', 'thetaM30Deg', 
	'theta30Deg', 'theta20degYaw200deg',
	'theta20degYawM200deg', 'turnaround', 
	'turnaroundGodown', 'yawShake',
	'yawDance', 'phiDance', 'thetaDance', 
	'vzDance', 'wave', 'phiThetaMixed',
	'doublePhiThetaMixed', 'flipAhead', 
	'flipBehind', 'flipLeft', 'flipRight']
.forEach(function(anim) {
	dc.register(path(id, "/anim/") + anim, function(drone, address, data) {
		drone.animate(anim, data[0]);
	})
});
['blinkGreenRed', 'blinkGreen', 'blinkRed', 
	'blinkOrange', 'snakeGreenRed',
	'fire', 'standard', 'red', 'green', 
	'redSnake', 'blank', 'rightMissile',
	'leftMissile', 'doubleMissile', 'frontLeftGreenOthersRed',
	'frontRightGreenOthersRed', 'rearRightGreenOthersRed',
	'rearLeftGreenOthersRed', 'leftGreenRightRed', 
	'leftRedRightGreen','blinkStandard']
.forEach(function(light) {
	dc.register(path(id, "/light/") + light, function(drone, address, data) {
		drone.animateLeds(light, data[0], data[1]);
	})
});

srv.on("message", function(msg, rinfo) {
	var address = msg[0];
	var parsed = parsePath(address).message;
	var resolved = dc[parsed];
	resolved.call(dc, parsed, msg);
});