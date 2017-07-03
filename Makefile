PATH := ./node_modules/.bin:$(PATH)

MONGODUMP = mongodump --db $(ANNO_MONGODB_NAME)
MONGORESTORE = mongorestore --db $(ANNO_MONGODB_NAME)

ANNO_MONGODB_NAME = 'anno'
BACKUP_PATH = $(PWD)/backup

BACKUP = $(shell date +"%Y-%m-%d_%H-%M-%S")
MONGODB_BACKUP = $(BACKUP_PATH)/$(BACKUP)

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

start:
	pm2 kill
	pm2 --no-daemon start pm2.prod.yml

backup:
	$(MONGODUMP) --out $(MONGODB_BACKUP)

restore:
	@if [ ! -e "$(MONGODB_BACKUP)" ];then echo "No such folder $(MONGODB_BACKUP)\nUsage: make $@ BACKUP=<backup-timestamp>" ; exit 2 ;fi
	$(MONGORESTORE) $(MONGODB_BACKUP)
