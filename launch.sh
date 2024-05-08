#!/usr/bin/sh
#AUTOSTART:YES

## CONFIG ##
#Some of these behaviors, like auto kill and rebuild, should become configurable.
#but in general, asking for a "launch" when in fact, it is already "launched" is to be intrepreted as a desired "re-set-and-re-launch".
#assume a common container-and-image name, singleton and all that.
FULLY_QUALIFIED_IMAGE_NAME="jrwarwick/radio_chatter"
COMMON_IMG_CON_NAME=$(basename ${FULLY_QUALIFIED_IMAGE_NAME} | sed 's/:.*$//')
##COMMON_CONTAINTER-IMAGE_NAME="${VARIABLE:=default}"
## maybe some parsage off of the fully qualified types of image names? mcr.microsoft.com/playwright:latest
##oneoff env var
export AIRLOCK_DIRNAME="${COMMON_IMG_CON_NAME}_airlock"
export AIRLOCK_CONTAINER_DIRPATH="/mnt/${AIRLOCK_DIRNAME}"
export EXTERNAL_PORT="8097"

#docker-container environment variable settings file
ls -1 ${COMMON_IMG_CON_NAME}.*.env | grep -v '\.example\.'
#probably freak out and suggest creating an env file?

#potential simple local mountable dir
#mkdir -p ./app ./db ./conf
#mkdir -p ./${COMMON_IMG_CON_NAME}
#mkdir -p ./${COMMON_IMG_CON_NAME}_home
mkdir -p ./${COMMON_IMG_CON_NAME}_airlock

## PREFLIGHT/STATUS ##
echo "$COMMON_IMG_CON_NAME" 
if docker ps --filter name="$COMMON_IMG_CON_NAME" ; then
	docker stop $COMMON_IMG_CON_NAME && docker rm $COMMON_IMG_CON_NAME
else
	echo "$COMMON_IMG_CON_NAME not running."
fi

##IFF first launch, try to determine next containter-offset/index number and/or available 800X  port availble


## (RE)BUILD ##
##docker pull $FULLY_QUALIFIED_IMAGE_NAME
if [ -r Dockerfile ] ; then
	docker build . --tag $COMMON_IMG_CON_NAME
else
	echo "No Dockerfile found, no build, assuming base docker image pulled will suffice..."
fi


## LAUNCH ##
#     (ext./net)  host : container (inside)
#docker run -it -p 5000:5000  --mount type=bind,source="$(pwd)"/db,target=/db  -e "SIGNAL_URI_BASE=http://$(hostname --fqdn):5000/" --env-file heartbeat-monitor.test.env heartbeatmon
#docker run -d -p 8082:80 ashphy/jsonpath-online-evaluator:latest
#docker run -d -p 8082:8080 -p 29418:29418 -v `pwd`/gitbucket:/gitbucket gitbucket/gitbucket
#The -it instructs Docker to allocate a pseudo-TTY connected to the container’s stdin; creating an interactive bash shell in the container. 

#docker run -d --name $COMMON_IMG_CON_NAME \
docker run -it --rm --name $COMMON_IMG_CON_NAME \
	-p ${EXTERNAL_PORT}:8080 \
	--mount type=bind,source="$(pwd)"/${AIRLOCK_DIRNAME},target=${AIRLOCK_CONTAINER_DIRPATH} \
	--env-file ${COMMON_IMG_CON_NAME}.test.env \
	$COMMON_IMG_CON_NAME \
	/bin/bash \
	# THE END

echo " docker run -it -p ${EXTERNAL_PORT}:80 --mount type=bind,source=\"$(pwd)\"/${AIRLOCK_DIRNAME},target=${AIRLOCK_CONTAINER_DIRPATH} --env-file ${COMMON_IMG_CON_NAME}.test.env $COMMON_IMG_CON_NAME  "


## WATCH-or-CODA ##
docker ps --last 3

#offer/suggest/auto-exec the portsmania thing, if it exists

sleep 4
docker logs  $COMMON_IMG_CON_NAME | egrep '^[A-Z]|rsyslog'

