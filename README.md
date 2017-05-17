# anno-backend-ubhd

Needs access to git@gitlab.ub.uni-heidelberg.de:Webservices/anno-common

## Setup

### Clone the repository

```sh
git clone --recursive
```

If accidently not cloned recursively, run

```sh
git submodule update --init
```

### Install dependencies

```js
npm install --link
```

Note the use of `--link`. If you get warnings about modules not being found, that's the cause.

### Start the server
npm start

Adapt `./start.sh` for configuration

* Users are defined in `users.yml` c.f.
  [anno-user](https://gitlab.ub.uni-heidelberg.de/Webservices/anno-common/tree/master/anno-mw-user-static)
* Rules are defined in `acl.yml` c.f.
  [anno-acl](https://gitlab.ub.uni-heidelberg.de/Webservices/anno-common/tree/master/anno-mw-user-static)




## NOSPC error

```sh
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
