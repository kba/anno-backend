# anno-backend-ubhd

> Setup of [anno](https://github.com/kba/anno) for a server with MongoDB backend

This repo contains no code but the configuration files and scripts to deploy
and run a [Web Annotation Protocol Server](https://www.w3.org/TR/annotation-protocol/) 
with a [few extensions](https://github.com/kba/anno#concepts).

It uses [Production Process Manager](https://github.com/Unitech/pm2) to deploy
and scale the service.

<!-- BEGIN-MARKDOWN-TOC -->
* [Setup](#setup)
	* [Node.JS](#nodejs)
	* [Repositories](#repositories)
	* [Install dependencies](#install-dependencies)
	* [Test the setup](#test-the-setup)
	* [Running productively](#running-productively)
* [Configuration](#configuration)
	* [Users](#users)
* [Troubleshooting](#troubleshooting)
	* [NOSPC error](#nospc-error)

<!-- END-MARKDOWN-TOC -->

## Setup

The service requires [Node.JS](https://github.com/nodejs/node) version 7 or up
and npm to install dependencies. All libraries and software related to running
this service will be installed in the local `./node_modules` folder.

For data storage, this service requires access to a MongoDB NoSQL database.
MongoDB is available in virtually all Linux distributions.

For setting up and running tasks you will also need:

* git
* make
* tar
* gzip
* mongodump, mongorestore (in Debian/Ubuntu: package `mongodb-clients`)

### Node.JS

We recommend using the [Node Version Manager](https://github.com/creationix/nvm) to install Node.JS.

We advise against using the Node.JS/npm versions provided by OS vendors since
these are often out-of-date.

### Repositories

Make sure that the `anno` monorepo is located at `./anno-common`.

If you have access to [UB Heidelberg's Gitlab instance](https://gitlab.ub.uni-heidelberg.de),
just clone recursively / initialize submodules.

```sh
git submodule update --init
```

Otherwise, clone the repository recursively from Github:

```sh
git clone --recursive https://github.com/kba/anno anno-common
```

### Install dependencies

```sh
make install
```

This will:

* Setup all sub-projects of anno-common
* Install repo-local dependencies (`pm2`)
* Set up symlinks

### Test the setup

To run a basic server w/o any authentication or support for users and access
rules, see the [`./pm2.test.yml`](./pm2.test.yml) configuration file.

```
./node_modules/.bin/pm2 --no-daemon start pm2.test.yml
```

This should start a server on port `33321` that will not use a MongoDB
collection but a flat file for storage, without authentication or ACL.

Note how all configuration is done using environment variables. You could also
set those variables in your shell or from a script and run the server directly.

### Running productively

See [`pm2.prod.yml`](./pm2.prod.yml):

* Use the [MongoDB backend](https://github.com/kba/anno/tree/master/anno-store-mongodb) for data storage (`ANNO_STORE='@kba/anno-store-mongodb'`)
* Provide a [Shibboleth-based authentication service](https://github.com/kba/anno/blob/master/anno-server/routes/auth-shibboleth.js) (`ANNO_SERVER_AUTH='shibboleth'`)
* Load the collection configuration from file for every HTTP request (`ANNO_MIDDLEWARE_PLUGINS='@kba/anno-plugins:PreCollectionFile'`)
* Before every store operation (`ANNO_STORE_HOOKS_PRE`):
  * Replace the `user` passed in the context with the user in the user file, if found (`@kba/anno-plugins:PreUserFile`)
  * Replace the `creator` of every annotation found with the user in the user file, if found (`@kba/anno-plugins:CreatorInjectorFile`)
  * Apply the [access control rules](https://github.com/kba/anno/tree/master/anno-plugins) against the context (`@kba/anno-plugins:PreAclFile`)
* After every store operation (`ANNO_STORE_HOOKS_POST`):
  * Replace the `creator` of every annotation found with the user in the user file, if found (`@kba/anno-plugins:CreatorInjectorFile`)

## Configuration

Basic configuration is done using environment variables. More complex data such
as users, collections and access rules can be placed in files.

### Collections

A collection is a distinct set of annotations with its own configuration. You
could use separate collections for separate services or authentication realms.

#### `secret`

`secret` is a private key to be used for signing JSON Web Tokens when using access control.

#### `purlTemplate`

`purlTemplate` is the collection-specific pattern of deriving a persistent,
nice, URL from an annotation.

If `purlTemplate` is not defined, no redirection will happen.

The syntax for interpolation is [mustache](https://mustache.github.io/), i.e.
variable names in double brackets, padded by a single space: `{{ variableName }}`.

You can use the following variables:

* `annoId`: The URL of the annotation
* `slug`: The identifier of the annotation, i.e. the last URL segment
* `targetId`: Determine the target of the annotation, using the algorithm in [anno-queries](https://github.com/kba/anno/tree/master/anno-queries#targetid)

### Users

Users can be defined either statically or in a JSON or YAML file (must end in `.json` or `.yml` resp.).

Users are defined in `users.yml`

### Access Control Rules

* Rules are defined in `acl.yml` c.f.
  [anno-acl](https://gitlab.ub.uni-heidelberg.de/Webservices/anno-common/tree/master/anno-mw-user-static)


## Troubleshooting

### NOSPC error

```sh
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
