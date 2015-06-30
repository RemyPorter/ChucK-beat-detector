public class DanceConfig {
	float yaw;
	fun float yawSpeed() {
		return yaw;
	}
	fun float yawSpeed(float y) {
		y => yaw;
		return yaw;
	}
}