echo "MESSAGE: $MESSAGE"
BETTER_NAME=$( echo $MESSAGE | tr '[A-Z]' '[a-z]' | sed -e 's/ (on|to|the|on|with|as|of) //g' -e 's/ \+/_/g' -e 's/[^0-9a-z_]//g' -e 's/\([^_]\+\){8}_*.*//' )

if [ -r audio/${BETTER_NAME}.ogg ] ; then
	echo " +- Already found a rendered audio file for that message, skipping."
	exit 0
fi

export VOICENAME=$(shuf -n 1 voicenames.txt)
#echo $MESSAGE | piper --model en_US-lessac-medium --output_file input.wav
#eventually when SSML is available in piper, we don't need that sed invocation
echo $MESSAGE | sed 's/\.\.\./\n/g' | piper --model $VOICENAME --output_file input.wav
sox input.wav -r 22050 input22k.wav ; mv input22k.wav input.wav
#STD edition
sox input.wav krssht.wav  rdo.ogg sinc -n 32767 1000-6000 compand 0.3,1 6:-70,-60,-20 -5 -90 0.2 overdrive 10
sox krssht.wav input.wav sin_432.wav krssht.wav rdo_full.ogg sinc -n 32767 1000-6000 compand 0.3,1 6:-70,-60,-20 -5 -90 0.2 overdrive 10

cp -p rdo_full.ogg ${BETTER_NAME}.ogg

