#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

echo "$INPUT_ENV" > env-file
echo "$INPUT_RUN" | sed -e 's/\\n/;/g' > semicolon_delimited_script

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL --env-file env-file $INPUT_IMAGE -c "`cat semicolon_delimited_script`"
