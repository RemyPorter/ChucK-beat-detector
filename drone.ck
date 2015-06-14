public class Drone {
	OscOut osc;

	fun void outdoorMode() {
		"true" => outdoor;
		"true" => noShell;
		2000 => verticalSpeed;
		6.0 => yawSpeed;
	}

	fun void connect(string host, int port) {
		(host, port) => osc.dest;
	}
	fun void takeoff() {
		osc.start("/takeoff").send();
	}
	fun void land() {
		osc.start("/land").send();
	}
	fun void light(string pattern, float freq, float durInMills) {
		osc.start("/light/" + pattern).add(freq).add(durInMills).send();
	}
	fun void anim(string pattern, float durInMills) {
		osc.start("/anim/" + pattern).add(durInMills);
	}
	fun void forward(float speed) {
		osc.start("/move/front").add(speed).send();
	}
	fun void up(float speed) {
		osc.start("/move/up").add(speed).send();
	}
	fun void down(float speed) {
		osc.start("/move/down").add(speed).send();
	}
	fun void backward(float speed) {
		osc.start("/move/back").add(speed).send();
	}
	fun void left(float speed) {
		osc.start("/move/left").add(speed).send();
	}
	fun void right(float speed) {
		osc.start("/move/right").add(speed).send();
	}
	fun void clockwise(float speed) {
		osc.start("/move/clockwise").add(speed).send();
	}
	fun void counterClockwise(float speed) {
		osc.start("/move/counterClockwise").add(speed).send();	
	}
	fun void stop() {
		osc.start("/move/stop").send();
	}
	fun void verticalSpeed(float speed) {
		osc.start("/config/vert_speed").add(speed).send();
	}
	fun void yawSpeed(float speed) {
		osc.start("/config/yaw_speed").add(speed).send();
	}
	fun void outdoor(string val) {
		osc.start("/config/outdoor").add(val).send();
	}
	fun void noShell(string val) {
		osc.start("/config/no_shell").add(val).send();
	}
	fun void reset() {
		osc.start("/reset").send();
	}
}