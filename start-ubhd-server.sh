#!/bin/bash

PATH="./node_modules/.bin:./anno/scripts:$PATH"

echo "Compiling ACL YAML"
YML2JSON_MIN=true yml2json.js acl.yml
echo "Compiling user YAML"
YML2JSON_MIN=true yml2json.js users.yml

export ANNO_SERVER_JWT_SECRET='@9g;WQ_wZECHKz)O(*j/pmb^%$IzfQ,rbe~=dK3S6}vmvQL;F;O]i(W<nl.IHwPlJ)<y8fGOel$(aNbZ'
export ANNO_STORE_MIDDLEWARES='@kba/anno-mw-user-static,@kba/anno-mw-acl-static'
export ANNO_ACL_RULES="$(cat acl.json)"
export ANNO_MW_USER_DATA="$(cat users.json)"
export ANNO_STORE='@kba/anno-store-mongodb'
export ANNO_PORT=3000
export ANNO_STORE_FILE="$PWD/store.nedb"

export ANNO_OPENAPI_HOST="serv42.ub.uni-heidelberg.de"
export ANNO_OPENAPI_BASEPATH="/kba"

export ANNO_BASE_URL='http://serv42.ub.uni-heidelberg.de/kba'
export ANNO_BASE_PATH='/kba'
cd anno/anno-server && make watch
