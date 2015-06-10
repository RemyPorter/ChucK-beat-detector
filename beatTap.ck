public class BeatTapper {
	Hid kbd;
	HidMsg msg;
	BeatTimer bd;
	fun void listen(int device) {
		kbd.openKeyboard(device);
		5 => bd.windowSize;
		while(true) {
			kbd => now;
			while(kbd.recv(msg)) {
				if (msg.isButtonDown()) {
					bd.event();
				}
			}
		}
	}
	fun dur interval() {
		return bd.interval();
	}
}