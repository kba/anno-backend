# anno-backend-ubhd

Needs access to git@gitlab.ub.uni-heidelberg.de:Webservices/anno-common

```sh
git clone --recursive
# if not cloned recursively:
# git submodule update --init
npm install
npm start
```

Adapt ./start-ubhd-server.sh for configuration

* Users are defined in `users.yml` c.f.
  [anno-user](https://gitlab.ub.uni-heidelberg.de/Webservices/anno-common/tree/master/anno-mw-user-static)
* Rules are defined in `acl.yml` c.f.
  [anno-acl](https://gitlab.ub.uni-heidelberg.de/Webservices/anno-common/tree/master/anno-mw-user-static)




## NOSPC error

```sh
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
