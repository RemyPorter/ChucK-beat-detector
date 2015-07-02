Drone d;
Spin clock;
Spin count;
StepDir f;
StepDir b;
StepDir l;
StepDir r;
StepDir u;
Stop s;
("localhost", 8081, 1) => d.connect;
d.reset();
d.outdoorMode();
d.takeoff();
2::second => now;
d.up(1.0);
6::second => now;
d.stop();
6 => clock.radiansPerSecond => count.radiansPerSecond;
1.0 => clock.rotations => count.rotations;
1.0::second => clock.beat => count.beat => f.beat => b.beat => l.beat => r.beat;
1.0 => f.speed => b.speed => l.speed => r.speed;
f.perform(d);
3::second => now;
for (0 => int i; i < 5; i++) {
	1::second => now;
	l.perform(d);
	r.perform(d);
	l.perform(d);
	f.perform(d);
	clock.perform(d);
	u.perform(d);
	s.perform(d);
	d.anim("flipAhead", 1000);
	u.perform(d);
	u.perform(d);
}
d.land();