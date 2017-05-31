#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

PATH="./node_modules/.bin:./anno-common/scripts:$PATH"

export ANNO_ACL_FILE="$PWD/acl.yml"
export ANNO_USER_FILE="$PWD/users.yml"

echo "Compiling collection.yml"
YML2JSON_MIN=true yml2json.js collections.yml
export ANNO_COLLECTION_DATA="$(cat collections.json)"

export ANNO_MONGODB_PORT=27017

export ANNO_STORE_HOOKS_PRE='@kba/anno-plugins:PreUserFile,@kba/anno-plugins:PreAclFile'
export ANNO_STORE_HOOKS_POST='@kba/anno-plugins:CreatorInjectorFile'
export ANNO_STORE='@kba/anno-store-mongodb'
export ANNO_PORT=3000

export ANNO_OPENAPI_HOST="serv42.ub.uni-heidelberg.de"
export ANNO_OPENAPI_BASEPATH="/anno"

export ANNO_BASE_URL='http://serv42.ub.uni-heidelberg.de'
export ANNO_BASE_PATH='/anno'

if [ -e "$PWD/profile.sh" ];then
    . "$PWD/profile.sh"
fi

cd anno-common/anno-server && make watch
