DEPS = \
    node_modules/@kba/anno-errors\
    node_modules/@kba/anno-pre-user-static\
    node_modules/@kba/anno-pre-acl-static\
    node_modules/@kba/anno-pre-service\
    node_modules/@kba/anno-post-creator-static\
    node_modules/@kba/anno-store-mongodb

bootstrap:
	cd anno-common; npm install; ./node_modules/.bin/lerna bootstrap

$(DEPS): node_modules/@kba/%: anno-common/%
	cd "$<"; npm link
	npm link "@kba/$*"

preinstall: bootstrap $(DEPS)
