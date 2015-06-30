public class Spin extends Step {
	float radsPerSecond;
	float distance;

	fun float radiansPerSecond(float rps) { 
		rps => radsPerSecond;
		return radsPerSecond;
	}
	fun float rotations(float r) {
		r => distance;
		return distance;
	}
	fun float radiansPerSecond() { return radsPerSecond; }
	fun float rotations() { return distance; }
	fun void perform(Drone drone) {
		distance * 2 * Math.PI => float deflection;
		radsPerSecond * (1::second / beat()) => float radsPerBeat;
		deflection / radsPerBeat => float beatRatio;
		1.0 => float step;
		if (distance < 0) -1 *=> step;
		while (Math.abs(beatRatio) > 1.0) {
			drone.spin(step);
			beat() => now;
			drone.stop();
			beat() => now;
			step -=> beatRatio;
		}
		if (Math.abs(beatRatio) < 1.0) {
			drone.spin(beatRatio);
			beat() => now;
		}
	}
}