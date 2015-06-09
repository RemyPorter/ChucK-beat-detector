Impulse imp => dac;
ListenForBeat beater;
SndBuf song => dac;
me.dir() + "/sounds/test.wav" => song.read;
0 => song.pos;
song => beater.source;

Event e;

spork ~ beater.listen(e);
1::samp => now;
while(true) {
	e => now;
	1.0 => imp.next;
	<<< "beat" >>>;
}