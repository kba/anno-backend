#!/bin/bash

PATH="./node_modules/.bin:$PATH"

export ANNO_JWT_SECRET='@9g;WQ_wZECHKz)O(*j/pmb^%$IzfQ,rbe~=dK3S6}vmvQL;F;O]i(W<nl.IHwPlJ)<y8fGOel$(aNbZ'
export ANNO_STORE_MIDDLEWARES=''
export ANNO_STORE='@kba/anno-store-file'
export ANNO_PORT=3000
export ANNO_STORE_FILE="$PWD/store.nedb"

cd anno/anno-server && nodemon -w "../anno-*" server.js
