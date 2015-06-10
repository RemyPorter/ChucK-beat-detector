Impulse imp => dac;
ListenForBeat beater;
SndBuf song => dac;
me.dir() + "/sounds/test.wav" => song.read;
0 => song.pos;
song => beater.source;

Event e;

spork ~ beater.listen(e);
1::samp => now;

OscOut osc;
("localhost", 8000) => osc.dest;
osc.start("/takeoff").send();
osc.start("/move").add(0.0).add(0.0).add(3.0).add(2).send();

while(true) {
	e => now;
	1.0 => imp.next;
	<<< "beat" >>>;
}