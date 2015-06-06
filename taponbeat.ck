SinOsc s => ADSR env => dac;
440 => s.freq;
0.5 => s.gain;

BeatTapper bt;

spork ~ bt.listen(0);

5::second => now;

fun void play() {
	env.keyOn();
	0.25::second => now;
	env.keyOff();
}

while (true) {
	play();
	bt.interval() => now;
}