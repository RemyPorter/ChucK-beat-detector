public class Stop extends Step {
	fun void perform(Drone drone) {
		drone.stop();
		beat() => now;
	}
}