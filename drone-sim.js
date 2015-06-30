function DroneSim() {
	var self = this;
	self.vector = [0,0,0,0];
	self.flying = false;
	var x = 0, y = 1, z = 2, t = 3;
	function op(name) {
		console.log(name, self.vector, self.flying);
	}
	self.config = function() {
		console.log("Configed: ", arguments);
	}
	self.stop = function() {
		self.vector = [0,0,0,0];
		op("stop");
	}
	self.land = function() {
		self.stop();
		self.flying = false;
		op("land");
	}
	self.takeoff = function() {
		self.flying = true;
		op("takeoff");
	}
	self.disableEmergency = function() {
		return true;
	}
	function direction(vectorAccess, multiplier) {
		return function(speed) {
			self.vector[vectorAccess] = speed * multiplier;
		}
	}
	[
		["left", x, 1], ["right", x, -1],
		["up", y, 1], ["down", y, -1],
		["clockwise", t, 1], ["counterClockwise", t, -1],
		["front", z, 1], ["back", t, -1]
	].forEach(function(dirVec) {
		self[dirVec[0]] =
			direction(dirVec[1], dirVec[2]) ;
		op(dirVec[0]);
	});

	self.animate = function(animation, duration) {
		console.log("Performing animation", animation, duration);
	}

	self.animateLeds = function() {
		console.log("Animating LEDs", arguments)
	}

	self.reset = function() {
		op("reset");
		self.land();
	}
}