# ubhd-anno-server

Needs access to github:kba/anno

```sh
git clone --recursive
npm install
npm start
```

Adapt ./start-ubhd-server.sh for configuration

## NOSPC error

```sh
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
