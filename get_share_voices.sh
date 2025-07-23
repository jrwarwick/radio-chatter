while read URI ; do
        curl -LOJ $URI
done <voicedownloadlist.txt

mv voicenames.txt voicenames.txt.prev
for V in *.onnx.json ; do
	echo  ${V//\.onnx\.json/} >> voicenames.txt
done

while read VN ; do
	piper --update-voices -m $VN
done <voicenames.txt
