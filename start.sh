#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

PATH="./node_modules/.bin:./anno-common/scripts:$PATH"

echo "Compiling collection.yml"
YML2JSON_MIN=true yml2json.js collections.yml
export ANNO_COLLECTION_DATA="$(cat collections.json)"

if [ -e "$PWD/profile.sh" ];then
    . "$PWD/profile.sh"
fi

pm2 kill
pm2 --no-daemon start pm2.prod.yml
