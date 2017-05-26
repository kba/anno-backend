DEPS = \
    node_modules/@kba/anno-errors\
    node_modules/@kba/anno-plugins\
    node_modules/@kba/anno-store-mongodb

bootstrap:
	cd anno-common; npm install; ./node_modules/.bin/lerna bootstrap

$(DEPS): node_modules/@kba/%: anno-common/%
	cd "$<"; npm link
	npm link "@kba/$*"

preinstall: bootstrap $(DEPS)
