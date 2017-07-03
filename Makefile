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

help:
	@echo "Targets:"
	@echo ""
	@echo "  bootstrap    Update anno-common after adding/removing deps"
	@echo "  preinstall   Run before setting up the server"
	@echo "  start        Start the server"
	@echo "  backup       Create a backup"
	@echo "  restore      Restore the backup given as MONGODB_BACKUP"
	@echo ""
	@echo "Variables"
	@echo ""
	@echo "  MONGODB_BACKUP"
	@echo "  ANNO_MONGODB_NAME    MongoDB database where annotations are stored"
	@echo "  BACKUP_PATH          Folder to contain backups"
	@echo "  BACKUP               Basename of the backup to create/restore. Defaults to timestamp ($(BACKUP))"

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
