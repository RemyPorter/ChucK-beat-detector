public class BeatTimer {
	time events[];
	int n;
	int currentEvent;
	fun void windowSize(int count) {
		new time[count] @=> events;
		for (0 => int i; i < count; i++) {
			now => events[i];
		}
		count => n;
		0 => currentEvent;
	}
	fun void event() {
		now => events[currentEvent % n];
		currentEvent++;
	}
	fun dur interval() {
		dur diffs;
		for (currentEvent => int i; i < currentEvent + n - 1; i++) {
			i % n => int e0;
			(i + 1) % n  => int e1;
			events[e1] - events[e0] +=> diffs;
		}
		return diffs / n;
	}
}