public class StepDir extends Step {
	int l;
	fun void left(int dir) { dir => l; }
	int r;
	fun void right(int dir) { dir => r; }
	int u;
	fun void up(int dir) { dir => u; }
	int d;
	fun void down(int dir) { dir => d; }
	int f;
	fun void forward(int dir) { dir => f; }
	int b;
	fun void back(int dir) { dir => b; }

	float spd;
	fun float speed() { return spd; }
	fun float speed(float s) { s => spd; return spd; }

	fun void perform(Drone drone) {
		if (l) {
			spd => drone.left;
		}
		if (r) {
			spd => drone.right;
		}
		if (f) {
			spd => drone.forward;
		}
		if (b) {
			spd => drone.backward;
		}
		if (u) {
			spd => drone.up;
		}
		if (d) {
			spd => drone.down;
		}
		if (beat() < 0.25::second) {
			beat() => now;
		}
		beat() => now;
		drone.stop;
	}
}