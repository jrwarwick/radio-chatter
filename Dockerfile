FROM ubuntu:latest

## packages
RUN  apt-get -y update && apt-get install -y \
	vim.tiny \
	curl \
	opus-tools sox \
	fortune file \
	python3 pip  \
	&& rm -rf /var/lib/apt/lists/*
RUN pip3 install piper-tts

RUN  mkdir /tmp/out
RUN  mkdir /usr/share/voices
WORKDIR /usr/share/voices
COPY get_share_voices.sh /usr/share/voices
COPY  voicedownloadlist.txt /usr/share/voices
RUN /bin/bash ./get_share_voices.sh

COPY app/ /app/
RUN  chmod 664 /app/*.py /app/*.sh
WORKDIR /app
#RUN /bin/bash /app/get_voices.sh
RUN cp -rp /usr/share/voices/* .

ENTRYPOINT /bin/sh /app/launch.sh

##docker build -t radio_chatter . && docker run -it -v ./out:/tmp/out --entrypoint /bin/bash radio_chatter

