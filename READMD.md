# VPN for Knowyourself

## 外网机器

服务端根据实际情况跑 frps 服务

比如默认 7000 暴露出来给 client 连接，7001 为 client 暴露出来的服务映射端口

```shell
docker run -p 7000:7000 -p 7001:7001 -d --name frps --restart always fatedier/frps:v0.38.0
```

## 内网机器

将需要登录的公钥放到 pubkeys 目录中

```shell
docker-compose up -d --remove-orphans --build
```
