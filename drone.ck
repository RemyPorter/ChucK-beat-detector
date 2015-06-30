public class Drone {
	OscOut osc;

	dur vectorTrack[3];
	time moveStart[3];
	0 => int x;
	1 => int y;
	2 => int z;
	0 => int moving;

	int id;
	fun string makePath(string pathString) {
		"/drone/ID" + id + pathString => string res;
		return res;
	}

	fun void outdoorMode() {
		"true" => outdoor;
		"true" => noShell;
		2000 => verticalSpeed;
		6.0 => yawSpeed;
	}

	fun void indoorMode() {
		"false" => outdoor;
		"false" => noShell;
		1000 => verticalSpeed;
		6.0 => yawSpeed;
	}

	fun void connect(string host, int port, int droneId) {
		(host, port) => osc.dest;
		droneId => id;
	}
	fun void takeoff() {
		osc.start(makePath("/takeoff")).send();
	}
	fun void zero() {
		osc.start(makePath("/zero")).send();
	}
	fun void moveToZero() {
		osc.start(makePath("/move/zero")).send();
	}
	fun void land() {
		osc.start(makePath("/land")).send();
	}
	fun void light(string pattern, float freq, float durInMills) {
		osc.start(makePath("/light/" + pattern)).add(freq).add(durInMills).send();
	}
	fun void anim(string pattern, float durInMills) {
		osc.start(makePath("/anim/" + pattern)).add(durInMills);
	}
	fun void forward(float speed) {
		osc.start(makePath("/move/front")).add(speed).send();
	}
	fun void up(float speed) {
		osc.start(makePath("/move/up")).add(speed).send();
	}
	fun void down(float speed) {
		osc.start(makePath("/move/down")).add(speed).send();
	}
	fun void backward(float speed) {
		osc.start(makePath("/move/back")).add(speed).send();
	}
	fun void left(float speed) {
		osc.start(makePath("/move/left")).add(speed).send();
	}
	fun void right(float speed) {
		osc.start(makePath("/move/right")).add(speed).send();
	}
	fun void clockwise(float speed) {
		osc.start(makePath("/move/clockwise")).add(speed).send();
	}
	fun void counterClockwise(float speed) {
		osc.start(makePath("/move/counterClockwise")).add(speed).send();	
	}
	fun void spin(float speed) {
		if (speed < 0) {
			counterClockwise(-1 * speed);
		} else {
			clockwise(speed);
		}
	}
	fun void stop() {
		osc.start(makePath("/move/stop")).send();
	}
	fun void verticalSpeed(float speed) {
		osc.start(makePath("/config/vert_speed")).add(speed).send();
	}
	fun void yawSpeed(float speed) {
		osc.start(makePath("/config/yaw_speed")).add(speed).send();
	}
	fun void outdoor(string val) {
		osc.start(makePath("/config/outdoor")).add(val).send();
	}
	fun void noShell(string val) {
		osc.start(makePath("/config/no_shell")).add(val).send();
	}
	fun void reset() {
		osc.start(makePath("/reset")).send();
	}
}