public class Step {
	dur beatLength;
	fun dur beat() { return beatLength; }
	fun dur beat(dur bl) { bl => beatLength; return beatLength; }

	Event endStep;
	fun Event endEvent() { return endStep; }
	fun void end() { endStep.broadcast(); }

	fun void perform(Drone d) {

	}
}