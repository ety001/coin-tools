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
regx='[[:digit:]]+ms th_a.+handle_block.+\] Got [[:digit:]]+ transactions on block [[:digit:]]+ by [[:alnum:][:punct:]]+ -- latency: [[:digit:]]+ ms'

if [[ $logs =~ $regx ]];
then
    echo 'ok'
    #curl -d "content=[ok]:smiley: $logs" "$notifyURL"
else
    curl -d "content=[err]:skull: $logs" "$notifyURL"
fi
