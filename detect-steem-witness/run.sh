#!/bin/bash
if [ -z $CONTAINER_NAME ];
then
    containerName="seed"
else
    containerName=$CONTAINER_NAME
fi
if [ -z $NOTIFY_URL ];
then
    notifyURL=""
else
    notifyURL=$NOTIFY_URL
fi

logs=`docker logs --tail=1 $containerName` 
regx="[ [:digit:] ]+ms.+th_a.+application.cpp:514.+handle_block.+].+Got [ [:digit:] ]+ transactions on block [ [:digit:] ]+ by [ [:alnum:] ]+ -- latency: [ [:digit:] ]+ms"

if [[ "$logs" =~ $regx ]];
then
    echo "ok"
else
	curl -d "content=$logs" "$notifyURL"
fi
