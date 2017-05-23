#!/bin/bash

PATH="./node_modules/.bin:./anno-common/scripts:$PATH"

echo "Compiling acl.yml"
YML2JSON_MIN=true yml2json.js acl.yml
export ANNO_ACL_DATA="$(cat acl.json)"

echo "Compiling user YAML"
YML2JSON_MIN=true yml2json.js users.yml
export ANNO_USER_DATA="$(cat users.json)"

echo "Compiling collection.yml"
YML2JSON_MIN=true yml2json.js collections.yml
export ANNO_COLLECTION_DATA="$(cat collections.json)"

export ANNO_SERVER_JWT_SECRET='@9g;WQ_wZECHKz)O(*j/pmb^%$IzfQ,rbe~=dK3S6}vmvQL;F;O]i(W<nl.IHwPlJ)<y8fGOel$(aNbZ'
export ANNO_STORE_HOOKS_PRE='@kba/anno-pre-service,@kba/anno-pre-user-static,@kba/anno-pre-acl-static'
export ANNO_STORE_HOOKS_POST='@kba/anno-post-creator-static'
export ANNO_STORE='@kba/anno-store-mongodb'
export ANNO_PORT=3000

export ANNO_OPENAPI_HOST="serv42.ub.uni-heidelberg.de"
export ANNO_OPENAPI_BASEPATH="/anno"

export ANNO_BASE_URL='http://serv42.ub.uni-heidelberg.de'
export ANNO_BASE_PATH='/anno'
cd anno-common/anno-server && make watch
