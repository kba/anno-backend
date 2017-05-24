#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

PATH="./node_modules/.bin:./anno-common/scripts:$PATH"

export ANNO_ACL_FILE="$PWD/acl.yml"
export ANNO_USER_FILE="$PWD/users.yml"

echo "Compiling collection.yml"
YML2JSON_MIN=true yml2json.js collections.yml
export ANNO_COLLECTION_DATA="$(cat collections.json)"

export ANNO_SERVER_JWT_SECRET='@9g;WQ_wZECHKz)O(*j/pmb^%$IzfQ,rbe~=dK3S6}vmvQL;F;O]i(W<nl.IHwPlJ)<y8fGOel$(aNbZ'
export ANNO_STORE_HOOKS_PRE='@kba/anno-rights:PreUserFile,@kba/anno-rights:PreAclFile'
export ANNO_STORE_HOOKS_POST='@kba/anno-rights:CreatorInjectorFile'
export ANNO_STORE='@kba/anno-store-mongodb'
export ANNO_PORT=3000

export ANNO_OPENAPI_HOST="serv42.ub.uni-heidelberg.de"
export ANNO_OPENAPI_BASEPATH="/anno"

export ANNO_BASE_URL='http://serv42.ub.uni-heidelberg.de'
export ANNO_BASE_PATH='/anno'
cd anno-common/anno-server && make watch
