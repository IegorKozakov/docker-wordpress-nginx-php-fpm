# docker-composeを使ったWordpress環境構築サンプル

## Installation

### CentOS

```shell
$ curl -sSL https://get.docker.com/ | sh
```

## Run

```shell
$ docker-compose build
$ docker-compose up -d
```

## Backup data

以下のコマンドを実行して出てくる`MountPoint`にデータが存在する。

```shell
$ docker volume inspect {volume name}
```

権限は、恐らくpolkitdあたりになっているはずなので、権限に注意してバックアップを取ること。
