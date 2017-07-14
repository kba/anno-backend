# anno-backend-ubhd

> Setup of [anno](https://github.com/kba/anno) for a server with MongoDB backend

This repo contains no code but the configuration files and scripts to deploy
and run a [Web Annotation Protocol Server](https://www.w3.org/TR/annotation-protocol/) 
with a [few extensions](https://github.com/kba/anno#concepts).

It uses [Production Process Manager](https://github.com/Unitech/pm2) to deploy
and scale the service.

<!-- BEGIN-MARKDOWN-TOC -->
* [Setup](#setup)
	* [Repositories](#repositories)
* [](#)
	* [Install dependencies](#install-dependencies)
	* [Start the server](#start-the-server)
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
set those variables in your shell and run the server directly.

### Running productively

See `pm2.prod.yml` 


## Configuration

Basic configuration is done using environment variables. More complex data such as users, collections and access rules
can be placed in files.

### Users

Users can be defined either statically or 

Users are defined in `users.yml`

* Rules are defined in `acl.yml` c.f.
  [anno-acl](https://gitlab.ub.uni-heidelberg.de/Webservices/anno-common/tree/master/anno-mw-user-static)


## NOSPC error

```sh
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
