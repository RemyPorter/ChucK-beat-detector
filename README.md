There are a few useful beat detection files in here. 

Running ```chuck rundetect.ck``` will launch a ChucK program that plays a sample WAV file and "clicks" (and prints) where it detects a beat in that input. It works okay, but could probably use some tuning. The code for beat detection lives in ```beatDetect.ck```

In practice, you can create an instance of the ```ListenForBeat``` class, chuck a UGen at its ```source``` property, and spork the ```listen(Event e)``` function. Whenever it thinks there's a beat, it broadcasts to that Event object to notify external code.

Running ```chuck runtap.ck``` launches a program that listens for keystrokes, and averages the time between strokes to find a beat. The main logic for that lives in ```beatTap.ck```.