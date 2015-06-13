public class Step {
	dur beatLength;
	fun dur beat() { return beatLength; }
	fun dur beat(dur bl) { bl => beatLength; return beatLength; }

	Drone d;
	fun Drone drone() { return d; }
	fun Drone drone(Drone dr) { dr => d; return d;}

	Event endStep;
	fun Event endEvent() { return endStep; }
	fun void end() { endStep.broadcast(); }

	fun void perform() {

	}
}