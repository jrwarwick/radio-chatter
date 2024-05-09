# Radio Chatter - Docker Container for Fun
Simple, quick, "ambience establishing" faux radio chatter generator. Fire this up and then point a web browser 
at the provided web service, find the player.html file and click on it, and you should have a quick and dirty 
background radio chatter generator machine. For fun? RPG background? LARP? Something?

Add or remove lines from ./app/messages.txt to customize what messages are rendered and played.

Uses the excellent Piper python package for easy and impressive TTS.


# Usage
Quick-start one-line startup:
```docker build -t radio_chatter . && docker run -it --name radio_chatter -v ./out:/tmp/out -p 0:8080 radio_chatter```

and to see what port to specify in your web client (probably in another shell):
```docker container port radio_chatter```

Or if you want to build it, and start up an interactive shell you can mess around before you actually launch app/launch.sh inside the container:
```docker build -t radio_chatter . && docker run -it --name radio_chatter -v ./out:/tmp/out -p 0:8080 --entrypoint /bin/bash radio_chatter```

# License
This project is licensed under the MIT License - see the LICENSE file for details.


#TODO
 - range of voices, 
	but keep track of "characters"

 - better krackelkrunches

 - add some variety to interference and distortion. Ringmod edition, shearing waves of static. 

 - occasional roger beeps.

 - frequency (of transmissions) sliders. Volume slider. 

 - visual animation of the "deck". der blinken lights.

 - embed source text into metadata tags and also parse them back out and display on page, pseudo-STT

 - some kind of simple form on UI web page that then allows for one-off text messages to be injected 

 - options for "publish" to shared path, or SCP to remote server, or some kind of icecast/mp3 stream

 - options for an LLM to generatively create the chatter
	- eventually: could also grab STT and feed it back into an LLM. Like maybe it kind of responds to you.
