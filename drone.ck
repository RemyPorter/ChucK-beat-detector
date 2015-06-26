public class Drone {
	OscOut osc;

	dur vectorTrack[3];
	time moveStart[3];
	0 => int x;
	1 => int y;
	2 => int z;
	0 => int moving;

	fun void startMoving(int dir) {
		stopMoving();
		now => moveStart[dir];
	}

	int id;
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

	fun string path(pathString) {
		return "/drone/ID" + id + pathString;
	}

	fun void connect(string host, int port, int droneId) {
		(host, port) => osc.dest;
		droneId => id;
	}
	fun void takeoff() {
		osc.start(path("/takeoff")).send();
	}
	fun void zero() {
		osc.start(path("/zero")).send();
	}
	fun void moveToZero() {
		osc.start(path("/move/zero")).send();
	}
	fun void land() {
		osc.start(path("/land")).send();
	}
	fun void light(string pattern, float freq, float durInMills) {
		osc.start(path("/light/" + pattern)).add(freq).add(durInMills).send();
	}
	fun void anim(string pattern, float durInMills) {
		osc.start(path("/anim/" + pattern)).add(durInMills);
	}
	fun void forward(float speed) {
		osc.start(path("/move/front")).add(speed).send();
	}
	fun void up(float speed) {
		osc.start(path("/move/up")).add(speed).send();
	}
	fun void down(float speed) {
		osc.start(path("/move/down")).add(speed).send();
	}
	fun void backward(float speed) {
		osc.start(path("/move/back")).add(speed).send();
	}
	fun void left(float speed) {
		osc.start(path("/move/left")).add(speed).send();
	}
	fun void right(float speed) {
		osc.start(path("/move/right")).add(speed).send();
	}
	fun void clockwise(float speed) {
		osc.start(path("/move/clockwise")).add(speed).send();
	}
	fun void counterClockwise(float speed) {
		osc.start(path("/move/counterClockwise")).add(speed).send();	
	}
	fun void stop() {
		osc.start(path("/move/stop")).send();
	}
	fun void verticalSpeed(float speed) {
		osc.start(path("/config/vert_speed")).add(speed).send();
	}
	fun void yawSpeed(float speed) {
		osc.start(path("/config/yaw_speed")).add(speed).send();
	}
	fun void outdoor(string val) {
		osc.start(path("/config/outdoor")).add(val).send();
	}
	fun void noShell(string val) {
		osc.start(path("/config/no_shell")).add(val).send();
	}
	fun void reset() {
		osc.start(path("/reset")).send();
	}
}