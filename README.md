# Radio Chatter - Docker Container for Fun
Simple, quick, "ambience establishing" faux radio chatter generator. 

Fire this docker container up via the launch.sh script and then point 
a web browser at the provided web service,navigate to player.html from 
the list, and you should have a quick and dirty background radio chatter 
generator machine. For fun? RPG background? LARP? Something?

Add or remove lines from ./app/messages.txt to customize what messages 
are rendered and played. You can also just download the rendered files
for use somewhere else, instead of loading up player.html.

Uses the excellent Piper python package for easy and impressive TTS.


# Usage
Quick-start one-line startup:
```./launch.sh```

or slightly more manual, but still one-line:
```docker build -t radio_chatter . && docker run -it --name radio_chatter -v ./out:/tmp/out -p 0:8080 radio_chatter```

and to see what port to specify in your web client (probably in another shell):
```docker container port radio_chatter```

Or if you want to build it, and start up an interactive shell you can mess around before you actually launch app/launch.sh inside the container:
```docker build -t radio_chatter . && docker run -it --name radio_chatter -v ./out:/tmp/out -p 0:8080 --entrypoint /bin/bash radio_chatter```


# License
This project is licensed under the MIT License - see the LICENSE file for details.


# TODO:
 - range of voices, 
	but keep track of "characters"

 - better krackelkrunches

 - add some variety to interference and distortion. Ringmod edition, shearing waves of static. 
	some this *might* be possible client side with webaudio hackery.

 - occasional roger beeps.

 - frequency (of transmissions) sliders. 

 - Volume slider needs something better than linear value application. I read a cool article on the web one time about a decent poorman's approximation of a reasonble logarithm thing.

 - volume slider and mute button need better styling. Bonus: place carefull *on top* of the background image giving effect that the panel is interactive.

 - visual animation of the "deck". der blinken lights.
	red dot should match/indicate mute state.
	include in this: move the transcription down onto a trapezoidal grey background that covers the bottom center "panel", giving the effect that it is a screen on the background image.
	then add in some of those fancy css CRT effects and glow/jitter.

 - embed source text into metadata tags and also parse them back out and display on page, pseudo-STT

 - options for "publish" to shared path, or SCP to remote server, or some kind of icecast/mp3/rtsp stream

 - some kind of simple form on UI web page that then allows for one-off text messages to be injected on the fly

 - options for an LLM to generatively create the chatter
	- eventually: could also grab STT and feed it back into an LLM. Like maybe it kind of responds to you. or at least a sentiment/emotional tone, which could be supplied by something external the background, such as a game engine.

