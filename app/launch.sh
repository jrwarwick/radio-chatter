echo One time pre-gen of some component sfx ...
SAMPLERATE=22050
CHANNELS=1
sox -V -r $SAMPLERATE -n -b 16 -c $CHANNELS sin_1k.wav synth .1 sin 1000 vol -10dB
sox -V -r $SAMPLERATE -n -b 16 -c $CHANNELS sin_432.wav synth .2 sin 432 vol -10dB
sox -V -r $SAMPLERATE -n -b 16 -c $CHANNELS krsssssh.wav synth 8 brownnoise 8 synth pinknoise mix synth sine amod 0.3 6
sox -V -r $SAMPLERATE -n -b 16 -c $CHANNELS krssht.wav synth .25 brownnoise 8 synth pinknoise mix synth sine amod 0.3 .08
sox -V -n -r $SAMPLERATE sine_500.wav synth 40.00 sine 500


while read MSG ; do
        export MESSAGE=$MSG
	bash chatter.sh
done <messages.txt

if [ -d audio ] ; then
	echo "fond audio subdirectory already in place."
else
	mkdir -v audio
fi
mv *.ogg audio


sox -T audio/rdo.ogg sine_500.wav ringmod.wav
sox ringmod.wav ringmod_filtered.wav sinc 750-250
sox ringmod_filtered.wav xwing.ogg overdrive 5

python3 -m http.server 8080
