This is a simple beat detector. ```beatTap.ck``` contains a class ```BeatDetector``` that exposes an event method. ```BeatDetector``` measures the time between subsequent calls to event and takes a windowed average of the last *n* events.

```BeatTapper``` ties the detector to a keyboard, but *any* source of events could be used to drive the Detector.

```taponbeat.ck``` is little more than a driver for simple synthesis to prove the detector/tapper works.