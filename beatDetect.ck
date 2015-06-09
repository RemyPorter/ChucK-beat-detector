public class ListenForBeat {
	//SndBuf song => dac;
	UGen song => FullRect r;
	fun void source(UGen src) {
		src @=> song => r;
	}

	0 => int running;
	64 => int bands;
	fun int numBands() { return bands; }
	fun int numBands(int bnds) { if (!running) bnds => bands; return bands;}
	16 => int bandThreshold;
	0.000005 => float threshold;
	2048 => int size;
	3 => int cooldown;
	20 => int low;
	10000 => int high;
	float step;
	BPF banded[256];
	FFT ffts[256];
	RMS rmses[256];
	float runningMeans[256];
	
	fun void build() {
		(high - low) / bands => step;
		for (0 => int i; i < bands; i++) {
			r => banded[i] => ffts[i] =^ rmses[i] => blackhole;
			step * (i + 1) => banded[i].freq;
			0.75 => banded[i].Q;
			size => ffts[i].size;
			Windowing.blackmanHarris(size/2) => ffts[i].window;
			0 => runningMeans[i];
		}
	}

	fun void listen(Event e) {
		build();
		1 => running;
		0 => int cooling;
		0 => int frames;
		while (true) {
			size::samp => now;
			frames++;
			0 => int highBands;
			for (0 => int i; i < bands; i++) {
				UAnaBlob d;
				rmses[i].upchuck() @=> d;
				d.fval(0) +=> runningMeans[i];
				if (d.fval(0) - threshold > runningMeans[i] / frames && d.fval(0) > 0.00005) {
					highBands++;
				}
			}
			if (highBands > bandThreshold && cooling <= 0) {
				e.broadcast();
				cooldown => cooling;
			}
			cooling--;
		}
		0 => running;
	}
}