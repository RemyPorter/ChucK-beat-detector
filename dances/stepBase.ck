public class Step {
	dur beatLength;
	fun dur beat() { return beatLength; }
	fun dur beat(dur bl) { bl => beatLength; return beatLength; }

	DanceConfig conf;
	fun DanceConfig config() { return conf; }
	fun DanceConfig config(DanceConfig c) {
		c @=> conf;
		return conf;
	}

	Event endStep;
	fun Event endEvent() { return endStep; }
	fun void end() { endStep.broadcast(); }

	fun void perform(Drone d) {

	}
}