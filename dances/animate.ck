class Animated extends Step {
	string anim;
	fun string animation() {
		return anim;
	}
	fun string animation(string a) {
		a => anim;
		return anim;
	}

	def perform(Drone d) {
		
	}
}