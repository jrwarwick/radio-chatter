while read URI ; do
        curl -LOJ $URI
done <voicedownloadlist.txt

for V in *.onnx.json ; do
	echo  ${V//\.onnx\.json/} >> voicenames.txt
done

while read VN ; do
	piper --update-voices -m $VN
done <voicenames.txt
