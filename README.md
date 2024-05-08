# Radio Chatter - Docker Container for Fun
Simple, quick, "ambience establishing" faux radio chatter generator. Fire this up and then point a web browser at the provided web service
and you should have a quick and dirty background radio chatter generator machine. For fun? RPG background? LARP? Something?
Uses the excellent Piper python package for easy and impressive TTS.

# Usage
Oneliner:
```docker build -t radio_chatter . && docker run -it -v ./out:/tmp/out --entrypoint /bin/bash radio_chatter```

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

 - embed text into metadata tags

 - some kind of simple embedded web page that then allows for a) one-off text messages to be injected and b) a randomized playlist 

 - options for "publish" to shared path, or SCP to remote server, or some kind of icecast/mp3 stream

 - options for an LLM to generatively create the chatter
	- eventually: could also grab STT and feed it back into an LLM. Like maybe it kind of responds to you.
