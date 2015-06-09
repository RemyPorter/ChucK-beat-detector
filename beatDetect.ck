64 => int bands;
40 => int threshold;
2048 => int size;
3 => int cooldown;
me.dir() + "/sounds/test.wav" => string filename;
Impulse beat => dac;

20 => int low;
10000 => int high;
(high - low) / bands => float step;
SndBuf song => dac;
song => FullRect r;
BPF banded[bands];
FFT ffts[bands];
RMS rmses[bands];
float runningMeans[bands];

for (0 => int i; i < bands; i++) {
	r => banded[i] => ffts[i] =^ rmses[i] => blackhole;
	step * (i + 1) => banded[i].freq;
	0.75 => banded[i].Q;
	size => ffts[i].size;
	Windowing.blackmanHarris(size/2) => ffts[i].window;
	0 => runningMeans[i];
}

filename => song.read;
0 => song.pos;
1.0 => song.rate;
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
		if (d.fval(0) > runningMeans[i] / frames && d.fval(0) > 0.00005) {
			highBands++;
		}
	}
	if (highBands > threshold && cooling <= 0) {
		1.0 => beat.next;
		cooldown => cooling;
	}
	cooling--;
}