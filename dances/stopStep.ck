public class Stop extends Step {
	fun perform(Drone drone) {
		drone.stop();
		beat() => now;
	}
}